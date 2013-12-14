SinOsc s => dac;

BPM tempo;
Mode mode;

fun void playSinneySound(int soundIndex) {
	if (soundIndex == -1) {
		0 => s.gain;
	} else {
    0.015 => s.gain;
    mode.getTone(soundIndex, 1) => s.freq;
	}
}

while(true){
  playSinneySound(Math.random2(0,8) - 1);      
  tempo.eighthNote => now;
}

