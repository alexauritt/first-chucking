// piano.ck
// Piano part
Rhodey piano[4];
piano[0] => dac.left;
piano[1] => dac; 
piano[2] => dac;
piano[3] => dac.right;

0.625*2 => float beat;

// BbM7 and Fm7
[[46,50,53,57],[41,44,48,51]] @=> int chords[][];

while(true){
    for( 0 => int i; i < 4; i++ )  
    {
        Std.mtof(chords[0][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
        Math.random2f(0.1, 0.3) => piano[i].gain;
    }
    beat::second => now;
    for( 0 => int i; i < 4; i++ )  
    {
        Math.mtof(chords[1][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
        Math.random2f(0.1, 0.3) => piano[i].gain;
    }
    beat::second => now;
}