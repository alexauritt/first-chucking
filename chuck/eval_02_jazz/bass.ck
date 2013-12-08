// bass.ck
// <<< "Assignment_6_Bb_Aeol_Jazz_Trio_with_sporking" >>>; 


// sound chain
Mandolin bass => Envelope env => NRev r => dac;  //stk instrument
SinOsc s => Envelope sEnv => dac;                //osc doubles bass w/ramdom slight detuning
 

// Initialize parameters
.07 => s.gain;   
0.1  => r.mix;
0.0  => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;

//*---------------------
//Note durations
//*---------------------
.625    => float Qn;  //Quarter Note
Qn * 2  => float Hn;  //Half Note
Qn * 4  => float Wn;  //Whole Note 
Hn + Qn => float Dh;  //Dotted Half
Qn / 2  => float En;  //Eighth Note 
Qn / 4  => float Sn;  //Sixteenth Note
En + Sn => float De;  //Dotted Eighth
Hn + En => float He;  //Half plus Eights


//*------------------------------------------------------------------------
// Define pitches using lowest midi pitches from Bb Aeolian mode
// C=0,C#=1,D=2...B=11
//*------------------------------------------------------------------------
10 => int Bb;   // Bb  
0  => int C;    // C 
1  => int Db;   // Db 
3  => int Eb;   // Eb 
5  => int F;    // F 
6  => int Gb;   // Gb
8  => int Ab;   // Ab 
-1 => int R;    // use -1 to indicate a rest  


//bass line - 2d array containing Note and register
// [R,0] indicates a rest
[ 
[Bb,2],[Bb,1],[C,2],[Db,2],[Ab,2],[Gb,2],[Bb,2],[F,2], 
[Gb,2],[Eb,2],[Db,2],[C,2],[Bb,1],[Bb,1],[Bb,1],[Bb,1],
[Bb,1],[Bb,1],[Bb,1],[Bb,1],[Bb,2],[Bb,1],[Bb,1],[Bb,1],
[R,0],[R,0],[R,0],[R,0],[Db,2],[Ab,1],[Bb,1]   
] @=> int   bassline[][];

//Array of note durations for bassline defined above
[
Hn,Dh,Qn,Qn,Qn,De,Sn,Qn,
Qn,Qn,Hn,Hn,Qn,Qn,Qn,Qn,
Qn,Hn,Qn,De,Sn,Qn,Qn,Qn,
Wn,Wn,Wn,De,Sn,Wn,Dh
] @=> float rhythm[]; 

//Array dynamics
[
.2,.3,.35,.4,.5,.5,.5,.5,
.4,.2,.2,.2,.1,.1,.1,.1,
.2,.2,.3,.4,.2,.5,.5,.5,
0.0,0.0,0.0,0.0,.2,.4,.1
] @=> float dynamics[]; 




//*--------------------------------------------------------------------------------------------------------------
// Function - Get Frequency, take in a a midi note and an octave and translates that into a frequency
// Example getFreq (0, 8) would translate 0(C in register -1) to midi 108(C in register 8) and return the frequency of 4186
// Argument 1 - int midi note from 0 thru 11 (C=0,C#=1,...B=11) 
// Argument 2 - int octave from  -1 thru 9   ( -1 = no change, 0 = up one octave, 1 = up 2 octaves etc)
// Returns a  frequency as a float
// If input is incorrect, display error message and return 0
//*--------------------------------------------------------------------------------------------------------------
fun float getFreq(int midiNote,int whichOct)
{
    if (midiNote == -1)
    {
        return 0.0;
    }
	// must be valid midi note from 0 to 11
    if (( midiNote < 0 ) || ( midiNote > 11 ))
	{
		<<< "Invalid Note - note must be between 0 and 11" >>>;
		return 0.0;
    }	
    // must be valid octave from -1 to 9
	if (( whichOct < -1 ) || ( whichOct > 9 ))
	{
		<<< "Invalid Octave - note must be between 0 and 9" >>>;
		return 0.0;
    }	
    // handle the condition that notes 8-11 don't have an octave 9
    if ( ( midiNote > 7 ) && ( whichOct > 8) )
	{
		<<< "Invalid Octave - note must be between 0 and 8, if the note is above 7" >>>;
		return 0.0;
    }	
	// assign to temp variable
    midiNote => int newNote;
    // add 12 for each octave
	for( -1 => int i; i <  whichOct; i++)
	{
		12 +=> newNote;
    }   
    // all edits passed, return the note converted to frequency       
    float freq;
    Std.mtof(newNote) => freq;   // convert midi to Hz
    return freq;
}

//*-------------------------------------
// Main Program
//*-------------------------------------

    0 => int midiNum;
    0 => int oct;
    0 => int noteCtr;

    // outer loop number of notes in the bassline
    for ( 0 => int i; i < bassline.cap(); i++ )
    {
        // inner loop - get the 2 parts of the note(pitch/register)    
        for ( 0 => int j; j < bassline[0].cap(); j++ )
        {
            if (j == 0)  // first slot in array is Midi note
            {
                bassline [i][j] => midiNum;
            }
            else         // second slot in array is which octave 
            {
                bassline [i][j] => oct;
            }
        }
        // call get freq function to get the note in Hz
        // if -1 midiNum is sent, function returns 0.0 
        getFreq(midiNum, oct) => float noteHz;
            
        // if a the note is set, play it
        if (noteHz > 0)
        {
           noteHz => bass.freq; 
           noteHz + Math.random2(0,3) => s.freq;  // random slight detuning
           
           //reduce dynamics to 20%                  
           dynamics[noteCtr] * .2 => bass.noteOn;                      
           1 => env.keyOn => sEnv.keyOn;          // double the bass with the SinOSc  
           rhythm[noteCtr]*.8::second => now;
            
           1 => bass.noteOff;                     // leave a little space between notes   
           1 => env.keyOff => sEnv.keyOff;
           rhythm[noteCtr]*.2::second => now;
           
        }
        else   // allow time to elapse for a rest 
        {
           rhythm[noteCtr]::second => now;
        }
        noteCtr++;    // increment ctr for arrays
   }
       
