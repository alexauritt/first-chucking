// Assignment_06_Aurough_Jazz_Band
// drums.ck
// Insert the title of your piece here

// Part of your composition goes here

BPM tempo;
tempo.quarterNote => dur quarter_note;
tempo.eighthNote => dur eighth_note;

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

SndBuf snare2 => dac;
1.0 => snare2.rate;
0.0 => snare2.gain;
me.dir(-1) + "/audio/snare_02.wav" => snare2.read;

// either play a snare sound or don't (boolean parameter)
fun void playSnare(int shouldPlaySnare) {
	if (shouldPlaySnare) {
		0 => snare.pos;
		snareGain => snare.gain;	
	} else {
		0 => snare.gain;
	}
}

fun void playGhostNotes() {
  0.15 => float ghostGain;

  0.0 => snare2.gain;
  tempo.sixteenthTriplet => now;

  0 => snare2.pos;
  ghostGain => snare2.gain;
  tempo.sixteenthTriplet => now;
  
  0 => snare2.pos;
  ghostGain => snare2.gain;
  tempo.sixteenthTriplet => now;  
}

// either play a click sound or don't (boolean parameter)
fun void playClick(int shouldPlayClick) {
	if (shouldPlayClick) {
		0 => click.pos;
		clickGain => click.gain;	
	} else {
		0 => click.gain;
	}
}

// either play a kick sound or don't (boolean parameter)
fun void playKick(int shouldPlayKick) {
	if (shouldPlayKick) {
		0 => kick.pos;
		kickGain => kick.gain;	
	} else {
		0 => kick.gain;
	}
}

// delegator function
fun void clickKickSnare(int shouldPlayClick, int shouldPlayKick, int shouldPlaySnare) {
	playClick(shouldPlayClick);
	playKick(shouldPlayKick);
	playSnare(shouldPlaySnare);
}

[3,-1,0,-1,4,-1,0,-1] @=> int drumPattern1[];
[3,0,0,0,4,0,0,0] @=> int drumPattern2[];
[0,2,4,3,1,-1,0,3] @=> int drumPattern3[];
[2,0,-1,4,3,4,-1,5] @=> int drumPattern4[];
[4,0,-1,3,2,3,-1,2] @=> int drumPattern5[];
[-1,-1,-1,-1,-1,-1,-1] @=> int drumEnd[];

// experimental -- don't use yet
[6,6] @=> int drumPattern6[];
[3,-1,0,-1,6] @=> int drumPattern7[];
[3,-1,0,-1,3,-1,7] @=> int drumPattern8[];


// -1 - rest
//  0 - click only
//  1 - kick only
//  2 - snare only
//  3 - click and kick
//  4 - click and snare
//  5 - click, kick, snare

// NOT OPERATIONAL YET, DO NOT USE
//  6 - snare roll, half note
//  7 - snare roll, quarter note

fun void playDrumSound(int soundIndex) {
	if (soundIndex == -1) {
		tempo.eighthNote => now;
	} else if (soundIndex == 0) {
		clickKickSnare(1,0,0);
		tempo.eighthNote => now;
	} else if (soundIndex == 1) {
		clickKickSnare(0,1,0);
		tempo.eighthNote => now;
	} else if (soundIndex == 2) {
		clickKickSnare(0,0,1);
		tempo.eighthNote => now;
	} else if (soundIndex == 3) {
		clickKickSnare(1,1,0);
		tempo.eighthNote => now;
	} else if (soundIndex == 4) {
		clickKickSnare(0,1,1);
		tempo.eighthNote => now;
	} else if (soundIndex == 5) {
		clickKickSnare(1,1,1);
		tempo.eighthNote => now;
	} 
}

fun void section( int pitzArray[]) {
  Math.random2(0,3) => int randy;
  for (0 => int i; i < pitzArray.cap(); i++) {
    if ((i == pitzArray.cap() - 1) && (randy == 0)) {
      spork ~ playGhostNotes();
    }
		playDrumSound(pitzArray[i]);      
  }
}

// sequencer
while(true){
	section(drumPattern1);
	section(drumPattern1);

	section(drumPattern1);
	section(drumPattern2);

	section(drumPattern1);
	section(drumPattern5);

	section(drumPattern4);
	section(drumPattern3);
	
	section(drumPattern1);
	section(drumPattern5);
	
	section(drumEnd);
}


// works in progress... not yet operational

fun void funFill() {
	
}

fun void drumRoll(dur playTime) {
	0 => kick.gain;
	0 => click.gain;
	0 => snare.pos;

	30 => int totalCount;
	playTime / totalCount => dur bounceTime;

	0.05 => float snareStart;
	0.025 => float snareTarget;
	
	snareStart - snareTarget => float snareDiff;
	snareDiff / totalCount => float increment;

	snareStart => snare.gain;

	0 => int counter;

	while(counter < totalCount) {

		// set gain
		counter * increment / snareDiff => float gainDecreasePercentage;
		Math.log(gainDecreasePercentage) * snareDiff => float gainDecrease;	
		snareStart - gainDecrease => snare.gain;
		0 => snare.pos;
		bounceTime => now;
		counter++;
	}
}
