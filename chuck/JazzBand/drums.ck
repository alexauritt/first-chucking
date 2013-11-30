// drums.ck
// Insert the title of your piece here

// Part of your composition goes here

0.625::second => dur quarter_note;
quarter_note / 2 => dur eighth_note;

0.4 => float clickGain;
0.75 => float snareGain;
0.5 => float kickGain;

SndBuf click => dac;
clickGain => click.gain;
me.dir(-1) + "/audio/click_02.wav" => click.read;

SndBuf kick => dac;
me.dir(-1) + "/audio/kick_03.wav" => kick.read;

SndBuf snare => dac;
0.8 => snare.rate;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;

fun void playSnare(int shouldPlaySnare) {
	if (shouldPlaySnare) {
		0 => snare.pos;
		snareGain => snare.gain;	
	} else {
		0 => snare.gain;
	}
}

fun void playClick(int shouldPlayClick) {
	if (shouldPlayClick) {
		0 => click.pos;
		clickGain => click.gain;	
	} else {
		0 => click.gain;
	}
}

fun void playKick(int shouldPlayKick) {
	if (shouldPlayKick) {
		0 => kick.pos;
		kickGain => kick.gain;	
	} else {
		0 => kick.gain;
	}
}

fun void clickKickSnare(int shouldPlayClick, int shouldPlayKick, int shouldPlaySnare) {
	playClick(shouldPlayClick);
	playKick(shouldPlayKick);
	playSnare(shouldPlaySnare);
}

[3,-1,0,-1,4,-1,0,-1] @=> int drumPattern1[];
[3,0,0,0,4,0,0,0] @=> int drumPattern2[];
[0,7,4,3,1,-1,0,3] @=> int drumPattern3[];
[2,0,-1,7,3,4,-1,5] @=> int drumPattern4[];
[4,0,-1,3,2,7,-1,2] @=> int drumPattern5[];


// -1 - rest
//  0 - click only
//  1 - kick only
//  2 - snare only
//  3 - click and kick
//  4 - click and snare
//  5 - click, kick, snare

fun void playDrumSound(int soundIndex) {
	if (soundIndex == -1) {
		clickKickSnare(0,0,0);
	} else if (soundIndex == 0) {
		clickKickSnare(1,0,0);
	} else if (soundIndex == 1) {
		clickKickSnare(0,1,0);
	} else if (soundIndex == 2) {
		clickKickSnare(0,0,1);
	} else if (soundIndex == 3) {
		clickKickSnare(1,1,0);
	} else if (soundIndex == 4) {
		clickKickSnare(0,1,1);
	} else if (soundIndex == 5) {
		clickKickSnare(1,1,1);
	}
	1::eighth_note => now;
}


fun void section( int pitzArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
		playDrumSound(pitzArray[i]);      
  }
}

while(true){
	section(drumPattern1);
	section(drumPattern2);
}