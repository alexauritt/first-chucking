SndBuf hiHat => dac;
SndBuf kick => dac;
SndBuf snare => dac;

string hiHatSamples[3];
me.dir() + "/audio/hiHat_01.wav" => hiHatSamples[0];
me.dir() + "/audio/hiHat_02.wav" => hiHatSamples[1];
me.dir() + "/audio/hiHat_04.wav" => hiHatSamples[2];

string snareSamples[3];
me.dir() + "/audio/snare_01.wav" => snareSamples[0];
me.dir() + "/audio/snare_02.wav" => snareSamples[1];
me.dir() + "/audio/snare_03.wav" => snareSamples[2];

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

    Math.random2(0,3) => int pattern;

    for (0 => int beat; beat < 12; beat++) {
        beat => subBeatIndex;
        (measure % 2 == 0) => isFirstPart;
        if (!isFirstPart) {
            subBeatIndex + 12 => subBeatIndex;
        }
        
        
        if (pattern == 0) {
            if ((subBeatIndex == 9) || (subBeatIndex == 12) || 
                (subBeatIndex == 17) || (subBeatIndex == 21)) {
                snareSamples[0] => snare.read;
                0 => snare.pos;
                0.1 * Math.random2(1,6) => snare.gain;
            }
        } else if (pattern == 1) {
            if ((subBeatIndex == 1) || (subBeatIndex == 2) || 
                (subBeatIndex == 15) || (subBeatIndex == 21)) {
                snareSamples[2] => snare.read;
                0 => snare.pos;
                0.1 * Math.random2(1,6) => snare.gain;
            }   
        } else if (pattern == 2) {
            if ((subBeatIndex == 6)) {
                snareSamples[0] => snare.read;
                0 => snare.pos;
                1.0 => snare.gain;
            }   
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
        
        0 => hiHat.pos;
        1::eighth_triplet => now;
    }
}