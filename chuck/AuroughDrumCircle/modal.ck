// Assignment_06_Aurough_Jazz_Band
// modal.ck
// Insert the title of your piece here

// Part of your composition goes here

0.625::second => dur quarter_note;
quarter_note / 2 => dur eighth_note;


[46.0, 48.0, 49.0, 51.0, 53.0, 54.0, 56.0, 58.0]  @=> float midiNotes[];

[4,6,3,6,4,5,3,2] @=> int pianoPattern1[];
[3,4,1,2,6,4,5,2] @=> int pianoPattern2[];
[5,6,7,5,3,1,2,4] @=> int pianoPattern3[];
[0,7,4,3,1,-1,0,3] @=> int pianoPattern4[];
[2,0,-1,7,3,4,-1,5] @=> int pianoPattern5[];
[4,0,-1,3,2,7,-1,2] @=> int pianoPattern6[];
[-1,-1,-1,-1,-1,-1,-1,-1] @=> int pianoRest[];

ModalBar modBar => Gain modBarGin => JCRev rev => Chorus chr => Gain master => dac;
0.05 => rev.mix;
0.15 => chr.modDepth;
0.7 => chr.modFreq;
0.6 => modBar.gain;

// different octave arrays
float lowOctaveNotes[8];
float midOctaveNotes[8];
float higherOctaveNotes[8];

for (0 => int m; m < 8; m++) {
    Std.mtof(midiNotes[m] - 12) => lowOctaveNotes[m];
    Std.mtof(midiNotes[m]) => midOctaveNotes[m];
    Std.mtof(midiNotes[m] + 12) => higherOctaveNotes[m];
}

fun void playPianoSound(int soundIndex) {
	if (soundIndex == -1) {
		0 => modBar.noteOn;
	} else {
    1 => modBar.noteOn;
    lowOctaveNotes[soundIndex] => modBar.freq;	
	}
}

fun void section( int pitzArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
			playPianoSound(pitzArray[i]);      
      1::eighth_note => now;
  }
}

while(true){
  // intro
	section(pianoPattern4);
  section(pianoPattern5);
	
	// drums and bass kick in here
	section(pianoPattern4);
	section(pianoPattern5);
	
	section(pianoPattern6);
	section(pianoPattern1);
	section(pianoPattern5);
	section(pianoPattern5);
	section(pianoPattern4);
	section(pianoPattern5);
	section(pianoPattern4);
	section(pianoPattern5);


	section(pianoRest);
	section(pianoRest);
	section(pianoRest);
	section(pianoRest);
}


