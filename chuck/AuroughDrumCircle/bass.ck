// Assignment_06_Aurough_Jazz_Band
// bass.ck
// Insert the title of your piece here

// Part of your composition goes here

Mandolin bass => NRev reverb => dac;
0.05 => reverb.mix;
0.02 => bass.stringDamping;
0.02 => bass.stringDetune;
0.03 => bass.bodySize;
0.1 => bass.gain;

BPM tempo;
Mode mode;

[4,1,7,3,2,-1,1,0] @=> int bassPattern1[];
[0,-1,-1,-1,3,-1,-1,1] @=> int bassPattern2[];
[0,-1,-1,-1,4,-1,3,1] @=> int bassPattern3[];
[0,-1,-1,-1,-1,-1,-1,-1] @=> int bassRest[];

fun void playBassSound(int soundIndex) {
	if (soundIndex == -1) {
		0 => bass.noteOn;
	} else {
    1 => bass.noteOn;
    mode.getTone(soundIndex, -1) => bass.freq;
	}
}

fun void section( int pitzArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
			playBassSound(pitzArray[i]);
			tempo.eighthNote => now;
  }
}

while(true){
	section(bassPattern2);
	section(bassPattern2);

	section(bassPattern2);
	section(bassPattern2);

	section(bassPattern2);
	section(bassPattern2);

	section(bassPattern2);
	section(bassPattern1);

	section(bassPattern2);
	section(bassPattern3);
  
  // THIS IS THE END
	section(bassRest);
}
