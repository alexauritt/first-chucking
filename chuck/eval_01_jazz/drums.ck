// drums.ck
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
Pan2 drumsPan => Gain master => dac;

SndBuf kick2 => drumsPan;
SndBuf kick5 => drumsPan;

0.6 => kick2.gain;
0.6 => kick5.gain;

0.9 => master.gain;

me.dir(-1) + "/audio/" => string samplesDir;

samplesDir + "/kick_02.wav" => kick2.read;
samplesDir + "/kick_05.wav" => kick5.read;

kick2.samples() => kick2.pos;
kick5.samples() => kick5.pos;

[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] @=> int kick2Pattern[];
[0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1] @=> int kick5Pattern[];

/**
 * If current tact matches kick2 pattern - play it
 */
fun void kick2Shred() {
  0 => int kick2counter;
  while (true) {
    kick2counter % kick2Pattern.cap() => int kick2tact;
    Std.rand2f(2, 3) => kick2.rate;
    if (kick2Pattern[kick2tact] == 1) {
      0 => kick2.pos;
    }
    sixteenth => now;
    kick2counter++;
  }
}

/**
 * If current tact matches kick2 pattern - play it
 */
fun void kick5Shred() {
  0 => int kick5counter;
  while (true) {
    kick5counter % kick5Pattern.cap() => int kick5tact;
    Std.rand2f(2, 3) => kick5.rate;
    if (kick5Pattern[kick5tact] == 1) {
      0 => kick5.pos;
    }
    sixteenth => now;
    kick5counter++;
  }
}


spork ~ kick2Shred();
spork ~ kick5Shred();

while(true){
    1::second => now;
}