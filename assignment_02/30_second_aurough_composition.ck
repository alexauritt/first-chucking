// 30 Second Aurough Ditty

SinOsc s => dac;
TriOsc t => dac;
SinOsc q => dac;

0.0 => t.gain;
0.2 => q.gain;

// notes (frequencies)
50 => float dM;
52 => float eM;
53 => float fM;
55 => float gM;
57 => float aM;
59 => float bM;
60 => float cM;
62 => float d2M;

// volume settings (gain)
0.0 => float silence;
0.3 => float quiet;
0.5 => float mid;

// durations (beats)
.25::second => dur beat;

// midi note sequence
[dM,eM,fM,gM,aM,bM,cM,d2M] @=> float midiNotes[];

float notes[8];
for (0 => int m; m < 8; m++) {
    Std.mtof(midiNotes[m]) => notes[m];
}

float randomNotes[4];
for (0 => int n; n < 4; n++) {
    notes[Math.random2(0,7)] => randomNotes[n];
}

Math.random2(0,7) => int randomIndexer;


for ( 0 => int k; k < 15; k++) {
    
    for ( 0 => int i; i < 8; i++) {    
        
        // random track
        notes[k * i * randomIndexer % 8] => q.freq;
        0.03 * k => q.gain;
        
        // melody track
        if (k < 2) {
            if ((i == 1) || (i == 6)) {
                notes[3] => t.freq;
                quiet => t.gain;
            } else if (i == 2) {
                silence => t.gain;  
            } else if (i == 3) {
                notes[7] => t.freq;
                quiet => t.gain;
            } else if (i == 5) {
                notes[1] => t.freq;
            }
        } else if (k < 4) {
            if ((i == 1) || (i == 9)) {
                notes[6] => t.freq;
                quiet => t.gain;
            } else if (i == 3) {
                silence => t.gain;  
            } else if (i == 4) {
                randomNotes[0] => t.freq;
                quiet => t.gain;
            } else if (i == 6) {
                notes[4] => t.freq;
            }
        } else if (k < 6) {
            if ((i == 1) || (i == 5)) {
                notes[Math.random2(0,7)] => t.freq;
                quiet => t.gain;
            } else if (i == 2) {
                silence => t.gain;  
            } else if (i == 4) {
                randomNotes[1] => t.freq;
                quiet => t.gain;
            } else if (i == 6) {
                notes[7] => t.freq;
            }
        } else if (k < 8) {
            if ((i == 2) || (i == 7)) {
                randomNotes[2] => t.freq;
                quiet => t.gain;
            } else if (i == 3) {
                silence => t.gain;  
            } else if (i == 6) {
                notes[3] => t.freq;
                quiet => t.gain;
            }
        } else if (k < 10) {
            if ((i == 1) || (i == 7)) {
                notes[3] => t.freq;
                quiet => t.gain;
            } else if (i == 3) {
                silence => t.gain;  
            } else if (i == 6) {
                notes[5] => t.freq;
                quiet => t.gain;
            }
        } else if (k < 12) {
            if ((i == 1) || (i == 7)) {
                notes[4] => t.freq;
                quiet => t.gain;
            } else if (i == 3) {
                silence => t.gain;  
            } else if (i == 6) {
                randomNotes[3] => t.freq;
                quiet => t.gain;
            }
        } else if (k < 15) {
            if ((i == 1) || (i == 7)) {
                notes[4] => t.freq;
                quiet => t.gain;
            } else if (i == 3) {
                silence => t.gain;  
            } else if (i == 6) {
                notes[1] => t.freq;
                quiet => t.gain;
            }
        } else {
            if ((i == 1) || (i == 7)) {
                notes[1] => t.freq;
                quiet => t.gain;
            } else if (i == 3) {
                quiet => t.gain;
            }
        }
        
        // rhythm track
        if (i % 2 == 0) {
            // turn sound on
            mid => s.gain;
            
            // increment to next note
            if (i == 0) {
                notes[1] => s.freq;
            } else if (i == 2) {
                notes[0] => s.freq;
            } else if (i == 4) {
                notes[6] => s.freq;
            } else if (i == 6) {
                notes[4] => s.freq;
            }
        } else { // turn sound off, for eight note (half second)
            silence => s.gain;
        }    
        
        1::beat => now;
    }
}