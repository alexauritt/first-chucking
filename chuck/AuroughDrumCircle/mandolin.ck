// Assignment_06_Aurough_Jazz_Band
// mandolin.ck
// Insert the title of your piece here

// Part of your composition goes here


Mandolin mandy => dac;
0.02 => mandy.stringDetune;
0.1 => mandy.gain;

BPM tempo;
Mode mode;

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
[-1,-1,-1,-1,-1,-1,-1,-1] @=> int mandyRest[];
[0,-1,-1,-1,-1,-1,-1,-1] @=> int mandyFinal[];

fun void playMandySound(int soundIndex) {
	if (soundIndex == -1) {
		0 => mandy.noteOn;
	} else {
    1 => mandy.noteOn;
    mode.getTone(soundIndex, 1) => mandy.freq;
	}
}

fun void section( int pitzArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
			playMandySound(pitzArray[i]);      
      tempo.eighthNote => now;
  }
}

while(true){
	section(mandyPattern4);
	section(mandyPattern5);
	section(mandyPattern6);
	section(mandyPattern9);
	section(mandyPattern8);
	section(mandyPattern7);
	section(mandyRest);
	section(mandyPattern1);
	section(mandyFinal);
}
