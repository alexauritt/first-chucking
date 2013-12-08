// sitar.ck
// "Assignment_6_ChucK_myJazz"

// Part of your composition goes here


//sound chain 
Sitar  sit =>  Gain sitGain => Gain master => dac;
sitGain => Gain sitFeedback => Delay delay => sitGain;
0.2 => sit.gain;


//sitar parametrs 
1.0 => sit.noteOn; //pluck strings 
0.55 => sit.pluck;


//timing parameter
2 => float beattime;

// feedback
beattime::second => delay.max;
beattime::second=> delay.delay;
0.1 => sitFeedback.gain;


5::second => now;


//global variables
[46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];//notes


while (true)
{   
   
    // time variasion
    Math.random2(1,3) => int factor;
    Std.mtof(notes[Math.random2(0, notes.cap()-1)]) => sit.freq;
    sit.noteOn(Math.randomf());
    
    //advance time
    beattime:: second => now;
    

}


  