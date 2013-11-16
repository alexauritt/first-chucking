<<< "3 Aurough Techo" >>>;


250::ms => dur quarter;

// notes (frequencies)
// midi note sequence
[51.0, 53.0, 55.0, 56.0, 58.0, 60.0, 61.0, 63.0] @=> float midiNotes[];

float lowOctaveNotes[8];
float midOctaveNotes[8];
float higherOctaveNotes[8];

string hiHatSamples[3];
me.dir() + "/audio/hiHat_01.wav" => hiHatSamples[0];
me.dir() + "/audio/hiHat_02.wav" => hiHatSamples[1];
me.dir() + "/audio/hiHat_04.wav" => hiHatSamples[2];

string snareSamples[3];
me.dir() + "/audio/snare_01.wav" => snareSamples[0];
me.dir() + "/audio/snare_02.wav" => snareSamples[1];
me.dir() + "/audio/snare_03.wav" => snareSamples[2];

string kickSamples[3];
me.dir() + "/audio/kick_01.wav" => kickSamples[0];
me.dir() + "/audio/kick_02.wav" => kickSamples[1];
me.dir() + "/audio/kick_03.wav" => kickSamples[2];


SinOsc s => Pan2 panS => dac;
SndBuf hiHat => dac;
SndBuf kick => dac;
SndBuf snare => dac;

0 => kick.gain;
0 => snare.gain;
0 => hiHat.gain;

0.2 => float hiHatGain;
0.6 => float kickGain;
0.9 => float snareGain;

hiHatSamples[0] => hiHat.read;
snareSamples[0] => snare.read;
kickSamples[0] => kick.read;

0.3 => s.gain;

for (0 => int m; m < 8; m++) {
    Std.mtof(midiNotes[m] - 12) => lowOctaveNotes[m];
    Std.mtof(midiNotes[m] - 12) => midOctaveNotes[m];
    Std.mtof(midiNotes[m] + 12) => higherOctaveNotes[m];
}

[4,6,3,6,4,5,3,2] @=> int pitzPattern1[];
[3,4,1,2,6,4,5,2] @=> int pitzPattern2[];
[5,6,7,5,3,1,2,4] @=> int pitzPattern3[];

[2,0,1,0,3,0,1,0] @=> int grooveArray1[];


fun void section( int pitzArray[], int grooveArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
    midOctaveNotes[pitzArray[i]] => s.freq;
    playDrumSound(grooveArray1[i]);
    1::quarter => now;
  }
}

fun void playDrumSound(int soundKey) {
    if (soundKey == 0) {
        <<< "zero" >>>;
        0 => kick.gain;
        0 => snare.gain;
        0 => hiHat.gain;
    } else if (soundKey == 1) {
        0 => hiHat.pos;
        0 => kick.gain;
        0 => snare.gain;
        hiHatGain => hiHat.gain;
    } else if (soundKey == 2) {
        0 => hiHat.pos;
        0 => kick.pos;        

        kickGain => kick.gain;
        0 => snare.gain;
        hiHatGain => hiHat.gain;
    } else if (soundKey == 3) {
        0 => hiHat.pos;
        0 => snare.pos;        
        0 => kick.gain;
        snareGain => snare.gain;
        hiHatGain => hiHat.gain;
    }

}



section(pitzPattern1, grooveArray1);
section(pitzPattern1, grooveArray1);

section(pitzPattern2, grooveArray1);
section(pitzPattern2, grooveArray1);




section(pitzPattern3, grooveArray1);
section(pitzPattern3, grooveArray1);
section(pitzPattern3, grooveArray1);
section(pitzPattern3, grooveArray1);
