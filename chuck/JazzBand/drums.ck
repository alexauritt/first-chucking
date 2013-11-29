// drums.ck
// Insert the title of your piece here

// Part of your composition goes here

0.625::second => dur quarter_note;
quarter_note / 2 => dur eight_note;


SndBuf click => dac;
0.4 => click.gain;
me.dir(-1) + "/audio/click_02.wav" => click.read;

SndBuf kick => dac;
0.8 => kick.gain;
me.dir(-1) + "/audio/kick_03.wav" => kick.read;

SndBuf snare => dac;
1.0 => snare.gain;
0.8 => snare.rate;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;


0 => int counter;

while(true){
		0 => click.pos;
		if (counter % 4 == 0) {
			0 => kick.pos;
			0 => snare.gain;
		} else if (counter % 4 == 2) {
			0 => snare.pos;
			0.8 => snare.gain;
		}
		counter++;
    quarter_note => now;
}