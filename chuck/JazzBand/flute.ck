// flute.ck
// Insert the title of your piece here

// Part of your composition goes here


Mandolin mandy => dac;
0.02 => mandy.stringDetune;
0.1 => mandy.gain;

0.625::second => dur quarter_note;
quarter_note / 2 => dur eighth_note;

[46.0, 48.0, 49.0, 51.0, 53.0, 54.0, 56.0, 58.0]  @=> float midiNotes[];

[3,4,1,2,6,4,5,2] @=> int mandyPattern1[];
[-1,2,1,-1,4,7,4,2] @=> int mandyPattern2[];
[5,6,7,5,3,1,2,4] @=> int mandyPattern3[];
[4,1,7,3,2,-1,1,0] @=> int mandyPattern4[];

[0,-1,0,3,-1,7,6,3] @=> int mandyPattern5[];
[5,6,-1,5,3,1,2,4] @=> int mandyPattern6[];
[5,6,7,-1,3,1,2,4] @=> int mandyPattern7[];
[4,5,7,2,3,-1,3,0] @=> int mandyPattern8[];

[-1,-1,-1,-1,-1,3,2,4] @=> int mandyPattern9[];
[0,-1,-1,-1,-1,-1,5,7] @=> int mandyPattern10[];

// different octave arrays
float lowOctaveNotes[8];
float midOctaveNotes[8];
float higherOctaveNotes[8];

for (0 => int m; m < 8; m++) {
    Std.mtof(midiNotes[m] - 12) => lowOctaveNotes[m];
    Std.mtof(midiNotes[m]) => midOctaveNotes[m];
    Std.mtof(midiNotes[m] + 12) => higherOctaveNotes[m];
}

fun void playMandySound(int soundIndex) {
	<<< "playing " >>>;
	if (soundIndex == -1) {
		0 => mandy.noteOn;
	} else {
    1 => mandy.noteOn;
    higherOctaveNotes[soundIndex] => mandy.freq;	
	}
}

fun void section( int pitzArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
			playMandySound(pitzArray[i]);      
      1::eighth_note => now;
  }
}

while(true){
	section(mandyPattern4);
	section(mandyPattern5);
	section(mandyPattern6);
	section(mandyPattern9);
	section(mandyPattern1);
	section(mandyPattern10);
}
