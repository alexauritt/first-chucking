// bass.ck
// "Assignment_6_ChucK_myJazz"

// Part of your composition goes here

// sound chain
Gain master => dac;
SndBuf stereo => Pan2 p  =>  master;
SndBuf kick => master;

//variables
1.0 => float panPosition; // initialize pan position value
0.1 => master.gain;

//create path
me.dir() => string path; 
"/../audio/stereo_fx_01.wav" => string filename;
path + filename => filename;

//read soundfile
filename => stereo.read;
me.dir() + "/../audio/hihat_04.wav" => kick.read;

//find samples
stereo.samples() => int numSamples;

// set playheads
kick.samples() => kick.pos;


//initialize counter
0=> int counter;

fun void playsound() {
    0 => int i;
    while( true ) {
        i % 4 => int beat;  
        if (( beat == 0) )//|| (beat == 4) 
        {
            0=> kick.pos;
            <<< beat >>>;
            numSamples => stereo.pos;
            -1.0 => stereo.rate;
        }
        1::second => now;
        i++;
    }
}

fun void panfun() {
    while( true ) {
        Math.random2f(-1.0, 1.0) => panPosition;
        panPosition => p.pan; // pan value
//        panPosition - .01 => panPosition; // decrement
        .5::second => now; // advance time
    }
}


// spork foo() and bar() on new shreds
spork ~ playsound();
spork ~ panfun();

// infinite time loop
while( true ) 1::second => now;
