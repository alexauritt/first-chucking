// Assignment_06_Aurough_Jazz_Band
// modal.ck
// Insert the title of your piece here

// Part of your composition goes here

BPM tempo;
Mode mode;
Panner panner;

[4,6,3,6,4,5,3,2] @=> int pianoPattern1[];
[3,4,1,2,6,4,5,2] @=> int pianoPattern2[];
[5,6,7,5,3,1,2,4] @=> int pianoPattern3[];
[0,7,4,3,1,-1,0,3] @=> int pianoPattern4[];
[2,0,-1,7,3,4,-1,5] @=> int pianoPattern5[];
[4,0,-1,3,2,7,-1,2] @=> int pianoPattern6[];
[-1,-1,-1,-1,-1,-1,-1,-1] @=> int pianoRest[];

ModalBar modBar => Gain modBarGin => JCRev rev => Chorus chr => Gain master => Pan2 p => dac;
0.05 => rev.mix;
0.15 => chr.modDepth;
0.7 => chr.modFreq;
0.6 => modBar.gain;

fun void playPianoSound(int soundIndex) {
	if (soundIndex == -1) {
		0 => modBar.noteOn;
	} else {
    1 => modBar.noteOn;
    mode.getTone(soundIndex, -1) => modBar.freq;	
	}
}

fun void section( int pitzArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
			playPianoSound(pitzArray[i]);

      panner.getPanPosition() => p.pan;
      tempo.eighthNote => now;
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


