// bass.ck
// Bass part
Mandolin bass => NRev r => dac;

TriOsc bassOsc => Envelope env => dac;
0.2 => bassOsc.gain;

0.625 => float beat;

[46, 48, 49, 51, 53, 54, 56, 58] @=> int scale[];

0.1 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
4 => int walkPos;
.3 => bass.gain;


fun void bassOscFun() {
    while(true) {
        Math.random2(0, scale.cap()-1) => int note;
        Std.mtof(scale[note]) => bassOsc.freq;
        1 => env.keyOn;
        beat::second => now;
        1 => env.keyOff;
        beat::second => now;   
    }
}

spork ~ bassOscFun();
while(true){
    Math.random2(-1,1) +=> walkPos; 
    if (walkPos < 0) 1 => walkPos;
    if (walkPos >= scale.cap()) scale.cap()-2 => walkPos;
    Std.mtof(scale[walkPos]-12) => bass.freq;
    Math.random2f(0.05,0.5) => bass.pluckPos;
    1 => bass.noteOn;
    0.6::second => now;
    1 => bass.noteOff;
    0.025::second => now;
}