<<< "3 Aurough Techo" >>>;


250::ms => dur quarter;

// notes (frequencies)
// midi note sequence
[51.0, 53.0, 55.0, 56.0, 58.0, 60.0, 61.0, 63.0] @=> float midiNotes[];

float lowOctaveNotes[8];
float midOctaveNotes[8];
float higherOctaveNotes[8];

SinOsc s => Pan2 panS => dac;
0.3 => s.gain;

for (0 => int m; m < 8; m++) {
    Std.mtof(midiNotes[m] - 12) => lowOctaveNotes[m];
    Std.mtof(midiNotes[m] - 12) => midOctaveNotes[m];
    Std.mtof(midiNotes[m] + 12) => higherOctaveNotes[m];
}

[4,6,3,6,4,5,3,2] @=> int pitzPattern1[];
[3,4,1,2,6,4,5,2] @=> int pitzPattern2[];
[5,6,7,5,3,1,2,4] @=> int pitzPattern3[];

[0,1,3,4,3,5,6,4] @=> int grooveArray1[];


fun void section( int pitzArray[], int grooveArray[]) {
  for (0 => int i; i < pitzArray.cap(); i++) {
    midOctaveNotes[pitzArray[i]] => s.freq;
    1::quarter => now;
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
