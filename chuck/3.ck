SndBuf hiHat => dac;
SndBuf kick => dac;

string hiHatSamples[3];
me.dir() + "/audio/hiHat_01.wav" => hiHatSamples[0];
me.dir() + "/audio/hiHat_02.wav" => hiHatSamples[1];
me.dir() + "/audio/hiHat_04.wav" => hiHatSamples[2];


me.dir() => string path;
string filename;


"/audio/kick_02.wav" => filename;
path + filename => filename;
filename => kick.read;

0.6 => kick.gain;
0 => kick.pos;
1 => kick.rate;

0.2 => hiHat.gain;
0 => hiHat.pos;
1.4 => hiHat.rate;


250::ms => dur quarter;
quarter * (1.0 / 3.0) => dur eighth_triplet;

int isFirstPart;
int subBeatIndex;

for (0 => int measure; measure < 32; measure++) {
    for (0 => int beat; beat < 12; beat++) {
      beat => subBeatIndex;
        (measure % 2 == 0) => isFirstPart;
        if (!isFirstPart) {
          subBeatIndex + 12 => subBeatIndex;
        }
        
        // kick
        if ((subBeatIndex == 0)) {
            0 => kick.pos;
            0.6 => kick.gain;
        } else if (subBeatIndex == 23) {
            if (Math.random2(0,5) == 0) {
                0 => kick.pos;
                0.6 => kick.gain;                
            }
        } else {
            0.0 => kick.gain;
        }
        
        // hihat rhythm
        if ((subBeatIndex == 0) || (subBeatIndex == 6) || (subBeatIndex == 12) || (subBeatIndex == 18)) {
            0.4 => hiHat.gain;
            hiHatSamples[1] => hiHat.read;
        } else if ((beat == 5) || (beat == 10)) {
            
            // swing the hi hat, sometimes
            if (Math.random2(0,7) == 0) {
                hiHatSamples[0] => hiHat.read;
                0.3 => hiHat.gain;
            } else {
                0.0 => hiHat.gain;
            }
        } else {
            0.0 => hiHat.gain;
        }
        //        if ((beat == 0) || (subBeatIndex == 3) || (subBeatIndex == 5)) {
        //            0.2 => hiHat.gain;
        //            Math.random2(0,2) => int which;
        //            hiHatSamples[which] => hiHat.read;
        //        } else if ((subBeatIndex == 1) || (subBeatIndex == 7) || (subBeatIndex == 14)) {
        //            0.8 => hiHat.gain;
        //            hiHatSamples[2] => hiHat.read;
        //        } else if ((subBeatIndex == 6) || (subBeatIndex == 13) || (subBeatIndex == 10)) {
        //            0.1 => hiHat.gain;
        //            hiHatSamples[1] => hiHat.read;
        //        } else if ((subBeatIndex == 9) || (subBeatIndex == 11)) {
        //            0.0 => hiHat.gain;  
        //        } else {
        //            hiHatSamples[0] => hiHat.read;
        //            0.6 => hiHat.gain;
        //        }
        
        
        0 => hiHat.pos;
        1::eighth_triplet => now;
    }
}