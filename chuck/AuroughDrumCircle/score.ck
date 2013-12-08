// Assignment_06_Aurough_Jazz_Band
// score.ck
// Insert the title of your piece here

// Add your composition files when you want them to come in

BPM bpm;
bpm.tempo(120);

Machine.add(me.dir() + "/modal.ck") => int modalID;

bpm.wholeNote * 2 => now;
Machine.add(me.dir() + "/drums.ck") => int drumID;
Machine.add(me.dir() + "/bass.ck") => int bassID;

bpm.wholeNote * 2 => now;
Machine.add(me.dir() + "/mandolin.ck") => int mandolinID;

bpm.wholeNote * 10.2 => now;

Machine.remove(drumID);
Machine.remove(bassID);
Machine.remove(mandolinID);
Machine.remove(modalID);