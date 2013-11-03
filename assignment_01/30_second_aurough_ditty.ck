// 30 Second Aurough Ditty

SinOsc s => dac;
TriOsc t => dac;

0.0 => t.gain;

// notes (frequencies)
1250 => int a;
1050 => int c;
837 => int e;
790 => int f;
704 => int g;

// volume settings (gain)
0.0 => float silence;
0.3 => float quiet;
0.5 => float mid;


// durations (beats)
.234375::second => dur beat;

// note sequence
[c,a,g,g,c,a,e,e] @=> int notes[];

// repeat note sequence 5 times
// total sequnce is '10 bars' long
for ( 0 => int k; k < 8; k++) {
    
    // run through note sequence
    // each note sequence is '2 bars'
    for ( 0 => int i; i < 16; i++) {    

        // melody track
        // skip melody for first 4 bars
        if (k > 1 && k < 8) {
            if ((i == 1) || (i == 9)) {
                f => t.freq;
                quiet => t.gain;
            } else if (i == 2) {
                silence => t.gain;  
            } else if (i == 3) {
                quiet => t.gain;  
            } else if (i == 5) {

                // modify melody slightly                
                if (k == 2) {
                    e => t.freq;                    
                } else if (k == 3) {
                    a => t.freq;
                } else if (k == 4 || k == 6) {
                    g => t.freq;
                } else if (k == 5) {
                    c => t.freq;
                } else if (k == 7) {
                    c => t.freq;
                }

            } else if (i == 13) {
                silence => t.gain;
            } else if (i == 11 && k == 7) {
                
                // tweak ending
                a => t.freq;
            }
        }

        // rhythm track
        if (i % 2 == 0) {
            // turn sound on
            mid => s.gain;
            
            // increment to next note
            i / 2 => int index;
            notes[index] => s.freq;
        } else { // turn sound off, for eight note (half second)
            silence => s.gain;
        }    
        1::beat => now;
    }
}