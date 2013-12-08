// piano.ck
// <<< "Assignment_6_Bb_Aeol_Jazz_Trio_with_sporking" >>>; 

// sound chain
Rhodey piano[5];

piano[0] => dac.left;
piano[1] => dac;
piano[2] => dac;
piano[3] => dac.right;
piano[4] => dac.right;

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
Qn + En => float Dq;  //Dotted Quarter

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
-1 => int R;    // rest  

//*-----------------------------------------------------------------
// 3 level array - contains the notes/chords for the piano part
// [ [R,0] ] - indicates a rest
// [ note1, register1 ] - note
// [ [note1, register1], [note2, register2] ] - 2 notes in a chord 
//*-----------------------------------------------------------------
[ 
  [ [R,0]                       ],      //measure 1 
  [ [Bb,3],[Eb,4],[F,4] ,[Ab,4] ],
  [ [Bb,3],[Eb,4],[F,4] ,[Gb,4] ],
  [ [F,4] ,[Ab,4],[C,5] ,[Eb,5] ],      //meas 1 beat4  
  [ [F,4] ,[Ab,4],[Bb,4],[Db,5] ],      
  [ [R,0]                       ],      //meas 3
  [ [R,0]                       ],      //meas 4   
  [ [Ab,4],[Bb,4],[Eb,5],[F,5]  ],
  [ [R,0]                       ],
  [ [Gb,4],[Bb,4],[Db,5],[Eb,5] ],
  [ [Gb,4],[Bb,4],[C,5] ,[Eb,5] ],
  [ [R,0]                       ],       //meas 5
  [ [Bb,3],[Db,4],[F,4] ,[Ab,4] ],       
  [ [C, 4],[Eb,4],[Gb,4],[Bb,4] ],       
  [ [R,0]                       ],       //meas 6
  [ [Bb,3],[Db,4],[F,4] ,[Ab,4] ],       
  [ [C, 4],[Eb,4],[Gb,4],[Bb,4] ],       
  [ [R,0]                       ],       //meas 7  
  [ [Bb,3],[Db,4],[F,4] ,[Ab,4] ],       
  [ [C, 4],[Eb,4],[Gb,4],[Bb,4] ],       
  [ [Db,4],[Gb,4],[Ab,4],[Db,5] ],       
  [ [Gb,4],[Bb,4],[Db,5],[Eb,5] ],       //meas 8
  [ [Ab,4],[C,5] ,[Db,5],[F,5]  ],       
  [ [Gb,4],[Bb,4],[Db,5],[Eb,5] ],       //meas 9 
  [ [Gb,4],[Bb,4],[C,5],[Eb,5]  ],       
  [ [Gb,4],[Bb,4],[Eb,5]        ],       //meas 9 beat 4 
  [ [Db,4],[Eb,4],[Gb,4],[Ab,4] ],       //meas 10
  [ [Bb,3],[F,4] ,[Gb,4]        ],       //meas 11
  [ [Bb,3],[C,4] ,[Db,4]        ],      
  [ [Bb,3],[Db,4],[Eb,4],[F,4]  ],       //meas 12
  [ [Bb,3],[Db,4],[Eb,4],[F,4],[Gb,5]],      
  [ [Bb,3],[Db,4],[Eb,4],[F,4],[F,5] ],      
  [ [Bb,3],[Db,4],[Eb,4],[F,4],[Eb,5]]      
]@=> int   chords[][][];

//Array of note durations for chords 
[
En,Qn,Dq,Dh,Hn,
Wn,
En,Dq,En,En,Qn,
En,Qn,He,En,Qn,He,
En,Qn,Dq,Qn,Hn,Hn,
Dq,Dq,Hn,Dh,Hn,Hn,
En,En,En,Wn
] @=> float rhythm[]; 

//Array of dynamics for chords 
[
0.0,.08,.11,.16,.08,
0.0,
0.0,.2,0,.03,.02,
0.0,.01,.01,0.0,.02,.02,
0.0,.03,.04,.05,.05,.06,
.07,.05,.03,.02,.01,.01,
0.0,.008,.004,.003
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

//*-------------------------------------------
//Main Program
//*-------------------------------------------

0 => int midiNum;
0 => int oct;
0 => int noteCtr;

// outer loop - for each chord
for ( 0 => int chordCtr; chordCtr < chords.cap(); chordCtr++ )   
{
    // next loop to build each chord 
    for ( 0 => int noteCtr; noteCtr < chords[chordCtr].cap(); noteCtr++ )
    {
       // inner loop - get the 2 parts of the note(pitch/register)
       for ( 0 => int ntReg; ntReg < 2; ntReg++ ) 
       {
           if (ntReg == 0)  // first slot in array is Midi note
           {
               chords [chordCtr][noteCtr][ntReg] => midiNum;
           }
           else            // second slot in array is which octave 
           {
               chords [chordCtr][noteCtr][ntReg] => oct;
           }
       }
       // call get freq function to get the note in Hz
       // if -1 midiNum is sent, function returns 0.0 
       getFreq(midiNum, oct) => float noteHz;       
       noteHz => piano[noteCtr].freq;               //set the pitch for each note 
       dynamics[noteCtr]  => piano[noteCtr].noteOn; //turn each note in the chord on
    }
    rhythm[chordCtr]::second => now;                //play the chord
}
    
