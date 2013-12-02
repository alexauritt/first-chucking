// Assignment 5 - Flute Jam

// Flutes with reverb and pan effect


//sound chains

//Flutes
Flute f1 => dac;
Flute f2 => dac;
0 => f1.gain => f2.gain; //when there's reverb/delay gain should be lower than 1
f1 => Pan2 p => dac;

// Modal Bar - models any rigid system by spectrum
// sounds like wood, glass, or metal
ModalBar m => dac;
.6 => m.gain;

// Impulse sound chain
Impulse imp => ResonZ filt => dac;
800 => filt.freq;
100 => filt.Q;

reverb(1); //call reverb function
PRC(0);


// Db Phrygian notes
[49, 50, 52, 54, 56, 57, 59, 61] @=> int phryg[];

// Main Program

// time parameter
.1 => float beattime;
1 => int factor;

//Intro
for( 0 => int i; i < 5; i++)
{
    Math.random2(0,8) => m.preset;  // 9 different presets
    <<< m.preset() >>>;
    Std.mtof(phryg[Math.random2(0,7)]) => m.freq;
    .75 => m.noteOn; // float whack the bar
    
    200 => imp.next; // generate 1 for 1 sample
    Std.mtof(phryg[Math.random2(0,7)]) => filt.freq;
    //.75:: second => now;
    .33::second => now;
}

// for loop
for( 0 => int i; i < phryg.cap()*2-2; i++)
{
    .4 => f1.gain => f2.gain; 
    
    // first flute controller
    1.0 => f1.noteOn; // blow!
    Std.mtof(phryg[Math.random2(0,3)]) => f1.freq;
    doppler(Math.random2f(-1,0),Math.random2f(0,1),.1);
    //0 => f.jetDelay;
    
    // second flute controller
    1.0 => f2.noteOn; // blow!
    Std.mtof(phryg[Math.random2(0,7)]) => f2.freq;
    
    
    // modal bar control
    Math.random2(0,8) => m.preset;  // 9 different presets
    <<< m.preset() >>>;
    Std.mtof(phryg[Math.random2(4,7)]) => m.freq;
    .75 => m.noteOn; // float whack the bar
    
    // Impulse rain drops
    200 => imp.next; // generate 1 for 1 sample
    Std.mtof(phryg[Math.random2(4,7)]) => filt.freq;
    
    
    
    Math.random2(1,3) => factor;
    beattime*factor::second => now;
    
    1 => f1.noteOff => f2.noteOff; // stop blowing
    .001::second => now;
    
}

//End note
1.0 => f1.noteOn; 
Std.mtof(phryg[1]) => f1.freq;
doppler(Math.random2f(-1,0),Math.random2f(0,1),.1);
1::second => now;
1 => f1.noteOff; // stop blowing
.125::second => now;


// Functions 

//function to add PRC reverb
fun void PRC(int r)
{
    if( r == 1 )
    {
        f1 => PRCRev rev => dac;
        .1 => rev.mix;
    }
}

//function add reverb
fun void reverb(int r)
{
    if( r == 1)
    {
        //sound chain delay
        Delay d[3]; // delay lines (every foot dist of sound travle = 1ms of delay -> 30ft = 60ms delay (approx)
        
        f1 => d[0];
        f1 => d[1];
        f1 => d[2];
        
        .06::second => d[0].max => d[0].delay;
        .08::second => d[1].max => d[1].delay;
        .1::second => d[2].max => d[2].delay;
        
        d[0] => d[0] => dac; 
        d[1] => d[1] => dac; 
        d[2] => d[2] => dac; 
        
        .2 => d[0].gain => d[1].gain => d[2].gain; 
    }
    
}

//function doppler pan
fun void doppler(float begin, float end, float grain)
{
    swell(.05,1,.01);
    for(begin => float d; d < end; d+grain => d)
    {
        d=> p.pan;
        .001::second => now;
    }
    
}

//function swell volume
fun void swell(float begin, float end, float grain)
{
    for(begin => float j; j < end; j+grain => j)
    {
        //j*100=> f.freq;
        j*.5=> f1.gain;
        .01::second => now;
    }
    for(end => float j; j > begin; j-grain => j)
    {
        j*.25=> f1.gain;
        .01::second => now;
    }
}
