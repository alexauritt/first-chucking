// Assignment_06_Aurough_Jazz_Band
// score.ck
// Insert the title of your piece here

// Add your composition files when you want them to come in

BPM bpm;
bpm.tempo(96);

Machine.add(me.dir() + "/modal.ck") => int modalID;

5::second => now;
Machine.add(me.dir() + "/drums.ck") => int drumID;
Machine.add(me.dir() + "/bass.ck") => int bassID;

5::second => now;
Machine.add(me.dir() + "/mandolin.ck") => int mandolinID;

22::second => now;

Machine.remove(drumID);
Machine.remove(bassID);
Machine.remove(mandolinID);
Machine.remove(modalID);