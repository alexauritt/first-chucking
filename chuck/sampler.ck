// Assignment_5_Petty Pepper Pot Boogie
// 22nd November 2013


// sound chain for xylophone
ModalBar m => dac.right;

// sound chain
Flute flu => dac.left; 




// sound chain for sitar
Mandolin mandy => Gain mandyGain => Gain master => dac;
mandyGain => Gain mandyFeedback => Delay delay => mandyGain;

//drums
Shakers shaker => master;

// drone
VoicForm singerDrones[4];
NRev droneRev => master;
for( 0 => int i; i < singerDrones.cap(); i++ )
{
    singerDrones[i] => droneRev;
    (0.5/singerDrones.cap()) => singerDrones[i].gain;
}

// sound chain
SndBuf snare => dac.right;
SndBuf clash => dac.left;

// open and read sound file

me.dir() + "/audio/snare_03.wav" => snare.read;
me.dir() + "/audio/hihat_04.wav" => clash.read;

// set playhead to end of file so no initial sound or take away playback at initialization

snare.samples() => snare.pos;
clash.samples() => clash.pos;

// global variables

[1,0] @=> int snare_ptrn_1[];
[1,1] @=> int snare_ptrn_2[];
[0,1] @=> int clash_ptrn_1[];



// function
fun void section( int snareArray[], int clashArray[], float beattime )
{
    // sequencer: for clash and snare drum beats
    for( 0 => int i; i < snareArray.cap(); i++ )
    {
        
        // if 1 in array then play click
        if( snareArray[i] == 1 )
        {
            0 => snare.pos; 
            .2 => snare.gain;
        }
        
        
        // if 1 in array then play clash
        if( clashArray[i] == 1 )
        {
            0 => clash.pos; 
            .2 => clash.gain;
        }
        
        0.02::second => now; 
    }
}




// global variables
[49, 50, 52, 54, 56, 57, 59, 61] @=> int dalek[];
[52-24, 54+24, 56+24, 61+24] @=> int drones[];

// timing parameter
0.25 => float beattime;

// mandolin feedback parameters
beattime::second => delay.max;
beattime::second => delay.delay;
.75 => mandyFeedback.gain;

// singer parameters (drone)
0.1 => droneRev.mix;
for( 0 => int i; i < singerDrones.cap(); i++ )
{
    0.06 => singerDrones[i].vibratoGain;
    "aaa" => singerDrones[i].phoneme;
    Std.mtof(drones[i])=> singerDrones[i].freq; 
}

// MAIN PROGRAM

// drone solo
2::second => now;

for( 0 => int b; b< 4; b++ )
{
    // time variation
    Math.random2(1,3) => int factor;
    // loop
    for( 0 => int i; i < dalek.cap(); i++ )
    {
        // mandolin control
        Std.mtof(dalek[Math.random2(0,dalek.cap()-1)]) => mandy.freq;
        mandy.noteOn(Math.randomf());
        0.5 => mandy.gain;
        
        // drum control
        6 => shaker.preset;
        1 => shaker.preset;
        1 => shaker.preset;
        Math.random2f(60.0,128.0) => shaker.objects;
        Math.random2f(0.8,1.0) => shaker.decay;
        shaker.noteOn(Math.random2f(0.0,4.0));   
        
        // bell control
        4 => m.preset;
        Math.random2f(200.0,1000.0) => m.freq;
        .1 => m.gain;
        1.0 => m.noteOn;
        
        // flute control
        Std.mtof(dalek[Math.random2(0,dalek.cap()-1)]-24) => flu.freq;
        Math.random2f(0.1,1.0) => flu.noteOn; // start blowing
        Math.random2f(0.1,1.0) => flu.jetDelay;
        0.5 => flu.gain;
        0.25::second => now;
        
        1 => flu.noteOff;
        
        // calling snare-clash
        section(snare_ptrn_1, clash_ptrn_1, .2);
        
        section(snare_ptrn_2, clash_ptrn_1, .4);
        
        
        //advance time
        beattime::second*factor => now;
    }
    <<< b >>>;
}
2::second => now;
