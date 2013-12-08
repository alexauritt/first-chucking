// drums.ck
// <<< "Assignment_6_Bb_Aeol_Jazz_Trio_with_sporking" >>>; 

//sound chain
SndBuf ride => dac.right;
SndBuf kick => dac.left;

me.dir(-1) + "/audio/kick_03.wav" => kick.read;
me.dir(-1) + "/audio/hihat_04.wav" => ride.read;

kick.samples()  => int kickSamples;
ride.samples()  => int rideSamples;

// turn off drums
kickSamples  => kick.pos;
rideSamples  => ride.pos;


//*---------------------
//Note durations
//*---------------------
.625    => float Qn;  //Quarter Note
Qn * 2  => float Hn;  //Half Note
Qn * 4  => float Wn;  //Whole Note 
Hn + Qn => float Dh;  //Dotted Half
Qn / 2  => float En;  //Eighth Note 
Qn / 4  => float Sn;  //Sixteenth Note
En + Sn => float De;  //Dotted Eighth
Hn + En => float He;  //Half plus Eights
Qn + En => float Dq;  //Dotted Quarter

0.0 => float R; //rest


// array of note durations for ride cymbal
[ Wn,
Qn,Qn,Qn,Qn,
Qn,De,Sn,Qn,Qn,
En,Dq,En,Dq,
En,Qn,He,
En,Qn,He,
En,Qn,Dq,Hn,
Hn,Hn,
Dh,
Wn,
Wn,
Dh,Hn
] @=> float rideRhythm[];

// array to indicate play=gain value or rest=R for ride cymbal
[R,
.1,.1,.1,.1,
.1,.2,.3,.4,.4,
R,.5,R,.6,
R,.2,.2,
R,.3,.4,
R,.1,.1,.1,
.1,.1,
R,
R,
R,
R,.1
] @=> float ridePlayRest[];

// array of note durations for ride cymbal
[ Wn,Wn,Wn,
Qn,Qn,Qn,Qn,
Qn,Qn,Qn,Qn,
Qn,Qn,Qn,Qn,
Qn,Qn,Qn,Qn,
Wn,Wn,Wn,Wn
] @=> float kickRhythm[];

// array to indicate play=1 or rest=1 for bass drum
[0.0,0.0,0.0,
.4,0,.5,0.0,
.1,.1,.2,.2,
.3,.3,.4,.4,
.2,.2,.2,.2,
0.0,0.0,0.0,0.0
 ] @=> float kickPlayRest[];



spork ~ playRide();  //start the ride cymbal part
spork ~ playKick();  //start the bass drum part
32::second => now;



// Ride cymbal part
fun void playRide()
{
    0 => int note;
    // loop for 12 measures
    for ( 0 => int meas; meas < 12; meas++ )
    {
        // loop for each note
        for ( 0 => note; note < rideRhythm.cap(); note++)
        {
            if (ridePlayRest[note] > 0)
            {    
                0 => ride.pos;
               .6 => ride.freq;
               ridePlayRest[note] * .5 => ride.gain;
            }
        rideRhythm[note]::second => now;
        }
    }
}

// Bass Drum part
fun void playKick()
{
    .3 => kick.gain;
    0 => int note;
    // loop for 12 measures
    for ( 0 => int meas; meas < 12; meas++ )
    {
        for ( 0 => note; note < kickRhythm.cap(); note++)
        {
            if (kickPlayRest[note] > 0)
            {   
                kickPlayRest[note] => kick.gain;
                0 => kick.pos;
            }
        kickRhythm[note]::second => now;
       }
    }
}

