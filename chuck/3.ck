// notes (frequencies)
50 => float dM;
52 => float eM;
53 => float fM;
55 => float gM;
57 => float aM;
59 => float bM;
60 => float cM;
62 => float d2M;

// midi note sequence
[dM,eM,fM,gM,aM,bM,cM,d2M] @=> float midiNotes[];

float notes[8];
float higherOctaveNotes[8];

for (0 => int m; m < 8; m++) {
    Std.mtof(midiNotes[m]) => notes[m];
    Std.mtof(midiNotes[m] + 12) => higherOctaveNotes[m];
}

SinOsc s => dac;
SndBuf hiHat => dac;
SndBuf kick => dac;
SndBuf snare => dac;
SndBuf effects => dac;

string hiHatSamples[3];
me.dir() + "/audio/hiHat_01.wav" => hiHatSamples[0];
me.dir() + "/audio/hiHat_02.wav" => hiHatSamples[1];
me.dir() + "/audio/hiHat_04.wav" => hiHatSamples[2];

string snareSamples[3];
me.dir() + "/audio/snare_01.wav" => snareSamples[0];
me.dir() + "/audio/snare_02.wav" => snareSamples[1];
me.dir() + "/audio/snare_03.wav" => snareSamples[2];

string stereo_fxSamples[2];
me.dir() + "/audio/stereo_fx_01.wav" => stereo_fxSamples[0];
me.dir() + "/audio/stereo_fx_02.wav" => stereo_fxSamples[1];


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
        
        // effects
        if ((measure == 4) & (beat == 0)) {
            stereo_fxSamples[0] => effects.read;
            effects.samples() => int sampleCount;
            sampleCount => effects.pos;
            -1.0 => effects.rate;
            0.4 => effects.gain;
        } else if ((measure == 14) && (beat == 0)) {
            stereo_fxSamples[1] => effects.read;
            1.3 => effects.rate;
            0 => effects.pos;
            0.065 => effects.gain;
        }        
        
        beat => subBeatIndex;
        (measure % 2 == 0) => isFirstPart;
        if (!isFirstPart) {
            subBeatIndex + 12 => subBeatIndex;
        }
        
        // rhythm track
        if (subBeatIndex % 2 == 0) {
            // turn sound on
            0.3 => s.gain;
            
            // increment to next note
            if (subBeatIndex == 0) {
                notes[1] => s.freq;
            } else if (subBeatIndex == 2) {
                notes[0] => s.freq;
            } else if (subBeatIndex == 4) {
                notes[6] => s.freq;
            } else if (subBeatIndex == 6) {
                notes[4] => s.freq;
            }
        } else { // turn sound off, for one beat)
            0.0 => s.gain;
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
        if ((subBeatIndex == 0) || (subBeatIndex == 6) || 
        (subBeatIndex == 12) || (subBeatIndex == 18)) {
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