SndBuf hiHatSound => dac;
SndBuf kick => dac;

me.dir() => string path;
"/audio/hihat_01.wav" => string filename;

path + filename => filename;
filename => hiHatSound.read;

"/audio/kick_02.wav" => filename;
path + filename => filename;
filename => kick.read;

0.6 => kick.gain;
0 => kick.pos;
1 => kick.rate;

0.2 => hiHatSound.gain;
0 => hiHatSound.pos;
1.4 => hiHatSound.rate;


0.125::second => dur eighth;
2 * eighth => dur quarter;

int isFirstPart;
int subBeatIndex;

for (0 => int measure; measure < 32; measure++) {
    for (0 => int beat; beat < 8; beat++) {
        beat => subBeatIndex;
        (measure % 2 == 0) => isFirstPart;
        if (!isFirstPart) {
            subBeatIndex + 8 => subBeatIndex;
        }
        
        // kick
        if ((subBeatIndex == 3) || (subBeatIndex == 11) || (subBeatIndex == 13)) {
            0 => kick.pos;
            0.6 => kick.gain;
        } else {
            // 0.0 => kick.gain;
        }
        
        // hihat rhythm
        if ((subBeatIndex == 0) || (subBeatIndex == 3) || (subBeatIndex == 5)) {
            0.2 => hiHatSound.gain;
        } else if ((subBeatIndex == 1) || (subBeatIndex == 7) || (subBeatIndex == 14)) {
            0.8 => hiHatSound.gain;
        } else if ((subBeatIndex == 6) || (subBeatIndex == 13) || (subBeatIndex == 10)) {
            0.1 => hiHatSound.gain;
        } else if ((subBeatIndex == 9) || (subBeatIndex == 11)) {
            0.0 => hiHatSound.gain;  
        } else {
            0.6 => hiHatSound.gain;
        }
        
        
        0 => hiHatSound.pos;
        1::eighth => now;
    }
}