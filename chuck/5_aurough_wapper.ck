<<< "5 Aurough Wapper" >>>;


.75::second => dur quarter;
quarter / 3 => dur eighth_triplet;

// notes (frequencies)
// midi note sequence
[49.0, 50.0, 52.0, 54.0, 56.0, 57.0, 59.0, 61.0] @=> float midiNotes[];

// different octave arrays
float lowOctaveNotes[8];
float midOctaveNotes[8];
float higherOctaveNotes[8];


// load audio files
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

Rhodey s => Gain rhodeGin => Pan2 panS => Gain master => dac;
SinOsc mel => dac;

SndBuf hiHat => dac;
SndBuf kick => dac;
SndBuf snare => dac;

// drums start quiet
0 => kick.gain;
0 => snare.gain;
0 => hiHat.gain;

0.2 => float hiHatGain;
0.6 => float kickGain;
0.9 => float snareGain;

hiHatSamples[0] => hiHat.read;
snareSamples[0] => snare.read;
kickSamples[0] => kick.read;

0.7 => s.gain;
0.1 => mel.gain;

for (0 => int m; m < 8; m++) {
    Std.mtof(midiNotes[m] - 12) => lowOctaveNotes[m];
    Std.mtof(midiNotes[m] - 12) => midOctaveNotes[m];
    Std.mtof(midiNotes[m] + 12) => higherOctaveNotes[m];
}

[4,6,3,6,4,5,3,2] @=> int pitzPattern1[];
[3,4,1,2,6,4,5,2] @=> int pitzPattern2[];
[5,6,7,5,3,1,2,4] @=> int pitzPattern3[];

[1,0,0,0,1,0,0,0] @=> int grooveArray0[];
[2,0,1,0,2,3,1,0] @=> int grooveArray1[];
[2,1,1,3,2,3,1,2] @=> int grooveArray2[];

[-1,-1,-1,-1,-1,-1,-1,-1] @=> int melodyArray0[];
[-1,-1,-1,3,4,7,6,2] @=> int melodyArray1[];
[-1,-1,-1,4,2,5,1,-1] @=> int melodyArray2[];
[-1,3,-1,4,-1,1,2,3] @=> int melodyArray3[];
[4,3,2,7,0,1,5,3] @=> int melodyArray4[];
[2,1,0,4,-1,5,2,7] @=> int melodyArray5[];

int randomMelody[8];
for (0 => int i; i < 8; i++) {
   Math.random2(-1,7) => randomMelody[i];
}

// variables to track panning
1 => int panRight;
0.0 => float panPosition;

// increment pan position
fun void changePan() {
    if (panRight == 1) {
        if (panPosition >= 1) {
            0 => panRight;
        } else {
            panPosition + 0.05 => panPosition;
            panPosition => panS.pan;
        }
    } else {
        if (panPosition <= -1) {
            1 => panRight;
        } else {
            panPosition - 0.05 => panPosition;
            panPosition => panS.pan;
        }
    }
}


fun void playAndPanPitzSound(int soundIndex) {
    s.noteOn(1);
    midOctaveNotes[soundIndex] => s.freq;
    changePan();
}


fun void section( int pitzArray[], int grooveArray[], int melodyArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
      for(0 => int t; t < 3; t++) {
          if (t == 0) {
              playAndPanPitzSound(pitzArray[i]);
              playDrumSound(grooveArray[i]);
              playMelody(melodyArray[i]);
          }
          1::eighth_triplet => now;
      }
  }
}

fun void silencio() {
   0 => kick.gain;
   0 => snare.gain;
   0 => hiHat.gain;
}

fun void hiHatOnly() {
        0 => hiHat.pos;
        0 => kick.gain;
        0 => snare.gain;
        hiHatGain => hiHat.gain;
}

fun void hiHatAndSnare() {
        hiHatSamples[0] => hiHat.read;
        0 => hiHat.pos;
        0 => kick.pos;        

        kickGain => kick.gain;
        0 => snare.gain;
        hiHatGain => hiHat.gain;
}

fun void playDrumSound(int soundKey) {
    if (soundKey == 0) {
        silencio();
    } else if (soundKey == 1) {
        hiHatSamples[0] => hiHat.read;
        hiHatOnly();
    } else if (soundKey == 2) {
        hiHatAndSnare();
    } else if (soundKey == 3) {
        hiHatSamples[1] => hiHat.read;
        0 => hiHat.pos;
        0 => snare.pos;        
        0 => kick.gain;
        snareGain => snare.gain;
        hiHatGain => hiHat.gain;
    }
}

fun void playMelody(int soundKey) {
    if (soundKey == -1) {
        0 => mel.freq;
    } else {
        higherOctaveNotes[soundKey] => mel.freq;
    }
}




section(pitzPattern1, grooveArray0, melodyArray0);

section(pitzPattern2, grooveArray2, melodyArray1);

section(pitzPattern3, grooveArray1, melodyArray2);

section(pitzPattern2, grooveArray1, melodyArray4);

section(pitzPattern2, grooveArray1, randomMelody);

section(pitzPattern1, grooveArray0, melodyArray5);

