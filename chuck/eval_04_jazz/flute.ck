// flute.ck
// Flute part
Flute solo => JCRev rev => dac;
0.1 => rev.mix;
solo => Delay d => d => rev;
0.625 :: second => d.max => d.delay;
0.3 => d.gain;
0.4 => solo.gain;

[46, 48, 49, 51, 53, 54, 56, 58] @=> int scale[];


while(true){
    (Math.random2(1,5) * 0.2) :: second => now;
    if (Math.random2(0,3) > 1) {
        Math.random2(0,scale.cap()-1) => int note;
        Math.mtof(24+scale[note])=> solo.freq;
        Math.random2f(0.3,1.0) => solo.noteOn;
        Math.random2f(0.1,0.3) => solo.gain;
    }
    else 1 => solo.noteOff;
}