// drums.ck
// Drums part

0.625 => float beat;

SndBuf hihat => Pan2 hihatPan => dac;
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;
.3 => hihat.gain;
SndBuf kick => dac;
me.dir(-1) + "/audio/kick_05.wav" => kick.read;
.3 => kick.gain;

fun float swing() {
    float swing;
    Math.random2(0,1) => int add;
    if (add > 0) {
            -0.2 => swing;
        } else {
            0.2 => swing;
        }
    return (swing + beat);
}

fun void kickFun() {
    while(true) {
        Math.random2f(0.1,.3) => kick.gain;
        Math.random2f(.9,1.2) => kick.rate;
        0=> kick.pos;
        (swing()*4)::second => now;
    }
}

fun void hihatFun() {
    while(true){
        Math.random2f(0.1,.25) => hihat.gain;
        Math.random2f(.9,1.2) => hihat.rate;
        swing()*0.5::second => now;
        Math.random2f(-1, 1) => hihatPan.pan;
        0 => hihat.pos;
    }
}

spork ~ kickFun();
spork ~ hihatFun();

while( true ) 1::second => now;
