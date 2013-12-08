// bass.ck
/**
 * Coursera.org
 * "Introduction to Programming for Musicians and Digital Artists "
 * Assignment 6 "Bass, Drums and Clarinet"
 * 
 * date: 2013.12.01
 */

// Timing settings
0.625::second => dur quarter;
quarter/2 => dur eighth;
quarter/4 => dur sixteenth;

// Chuck net configuration
TriOsc bass => Pan2 pan => Gain master => dac;

0.7 => master.gain;

// Initial bass gain value
0.4 => float bassGain;
// Amplitude of bass gain modulation
0.4 => float bassAmp;

bassGain => bass.gain;

// MIDI notes array in Bb Aeolian mode. -1 means pause
[-1, 46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];

// Bass melody array. Contains sequence of "notes" array elements
[7, 7, 7, 7, 7, 7, 7, 7] @=> int bassMelody[];
// Bass melody multiply coefficients array.
[0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1] @=> float bassCoeff[];

0 => int bassCounter;

/**
 * This function runs in separate thread and modulates bass amplitude.
 * May be there is more simple way to do it with chuck unit generators,
 * but I did not find it (I know only how to do frequency modulation).
 * If you know solution - write please in assignment feedback.
 */
fun void bassModulator () {
  0 => int phase;
  0.001::second => dur deltaT;
  while (true) {
    bassGain + bassAmp * Math.sin(4*3.1416*phase*deltaT/quarter) => bass.gain;
    deltaT => now;
    phase++;
  }
}

/**
 * This function plays bass melody according to bassMelody and bassCoeff arrays
 */
fun void bassPlay () {
  while (true) {
    bassCounter % bassMelody.cap() => int bassTact;
    if (bassMelody[bassTact] != 0) {
      Std.mtof(notes[bassMelody[bassTact]]) * bassCoeff[bassTact] => bass.freq;
    } else {
      0 => bass.freq;
    }
    quarter => now;
    bassCounter ++;
  }
}

spork ~ bassPlay();
spork ~ bassModulator();

while(true){
    1::second => now;
}