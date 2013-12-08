//sound chain 
Mandolin  m =>  Gain mGain => Gain master => dac;
mGain => Gain mFeedback => Delay delay => mGain;


//mandolin parametrs 
1.0 => m.noteOn; //pluck strings 
0.55 => m.bodySize;
0.0 => m.stringDetune;
0.2 => m.gain;

//timing parameter
.4 => float beattime;
0.625=> float qNote; //Make quarter Notes 


// feedback
beattime::second => delay.max;
beattime::second=> delay.delay;
0.2 => mFeedback.gain;


3::second => now;


//global variables
[46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];//notes
int thenote;

while (true)
{   
   

    
    Math.random2f(0.1,0.4) => m.pluckPos;
    Math.random2(0, notes.cap()-1) => thenote;
    Std.mtof(notes[thenote]) => m.freq;
    m.noteOn(Math.randomf());
    
    if ( notes[thenote] == 51)
    {
    qNote:: second => now;
    }
    
    
    else 
    
    //advance time
    beattime:: second => now;
  
}


  