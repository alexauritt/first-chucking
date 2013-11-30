// score.ck
// Insert the title of your piece here

// Add your composition files when you want them to come in






Machine.add(me.dir() + "/modal.ck") => int modalID;

5::second => now;

Machine.add(me.dir() + "/drums.ck") => int drumID;
Machine.add(me.dir() + "/flute.ck") => int fluteID;
Machine.add(me.dir() + "/bass.ck") => int bassID;

10::second => now;


5::second => now;

10::second => now;

Machine.remove(drumID);
Machine.remove(bassID);
Machine.remove(fluteID);
Machine.remove(modalID);