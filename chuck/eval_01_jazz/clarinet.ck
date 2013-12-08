// clarinet.ck
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
Clarinet cl => Delay d => Pan2 pan => Gain master => dac;
d => Gain feedback => d;

0.95 => feedback.gain;

0.08::second => d.delay;

0.3 => master.gain;

0.2 => cl.gain;

// MIDI notes array in Bb Aeolian mode. -1 means pause
[-1, 46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];

/* Clarinet melody array. Contains sequence of "notes" array elements
 * At first I wanted to make this melody more various but then
 * I decided to play with muliplying coefficient for notes
 */
[7, 7, 7, 7, 7, 7, 7, 7] @=> int clMelody[];
// Clarinet melody multiply coefficients array.
[1.0, 2.0, 1.0, 2.0, 2.0, 4.0, 2.0, 4.0] @=> float clCoeff[];

0 => int clCounter;

// Initial pan value
0 => float initialPan;
// Pan amplitude
1.0 => float panAmp;

/**
 * This function controls Clarinet panning according to sinusoidal function
 */
fun void clPanControl () {
  0 => int phase;
  0.001::second => dur deltaT;
  while (true) {
    initialPan + panAmp * Math.sin(4*3.1416*phase*deltaT/quarter) => pan.pan;
    deltaT => now;
    phase++;
  }
}

/**
 * This function plays clarinet melody according to clMelody and clCoeff arrays
 */
fun void clPlay () {
  while (true) {
    clCounter % clMelody.cap() => int clTact;
    notes[clMelody[clTact]] => int note;
    if (note != -1) {
      Std.mtof(note) * clCoeff[clTact] => cl.freq;
      1 => cl.noteOn;
    }
    eighth => now;
    1 => cl.noteOff;
    clCounter++;
  }
}

spork ~ clPlay();
spork ~ clPanControl();

while(true){
    1::second => now;
}