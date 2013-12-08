// drole.ck
// "Assignment_6_ChucK_myJazz"

// Part of your composition goes here

//sound chain 
 Gain master => dac;

//Drones
VoicForm singerDrones[4];
NRev droneRev => master;
for( 0 => int i; i < singerDrones.cap(); i++ ) {
      singerDrones[i] => droneRev;
      (.5/singerDrones.cap()) => singerDrones[i].gain;
}    

[51, 53, 54, 56, 58] @=> int drones[];

//timing parameter
.3 => float beattime;

// time control 
0 => int counter;
24::second => dur totaldur;
now + totaldur => time totaldur2;

for( 0 => int i; i < singerDrones.cap(); i++ ) {
     .3=> droneRev.mix;     
     .5=> droneRev.mix;     
     .01 => singerDrones[i].vibratoGain;
     "lll" => singerDrones[i].phoneme;
     Std.mtof(drones[i]) => singerDrones[i].freq;
} 

while( true ) 

{
    Math.random2(1, 3) => int factor;
    beattime::second * factor => now;
}

