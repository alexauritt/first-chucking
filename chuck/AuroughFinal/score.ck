// Assignment_06_Aurough_Jazz_Band
// score.ck
// Insert the title of your piece here

// Add your composition files when you want them to come in

// 96 beats per minute means that...
// ...each beat (i.e. each quarter note)
// ... is 0.625 seconds
BPM bpm;
bpm.tempo(65);


Machine.add(me.dir() + "/modal.ck") => int modalID;
Machine.add(me.dir() + "/sinner.ck") => int sinnerID;
Machine.add(me.dir() + "/drums.ck") => int drumID;
Machine.add(me.dir() + "/bass.ck") => int bassID;

// wait another 2 measures

bpm.wholeNote * 4 => now;

Machine.add(me.dir() + "/mandolin.ck") => int mandolinID;

bpm.wholeNote * 16 => now;

Machine.remove(sinnerID);

bpm.wholeNote * 0.5 => now;

Machine.remove(drumID);
Machine.remove(bassID);
Machine.remove(mandolinID);
Machine.remove(modalID);
