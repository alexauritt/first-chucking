// score.ck
// "Assignment_6_ChucK_myJazz"

// Add your composition files when you want them to come in
Machine.add(me.dir() + "/shitar.ck") => int shitarID;
Machine.add(me.dir() + "/bass.ck") => int bassID;

10::second => now;

Machine.add(me.dir() + "/drole.ck") => int droleID;

10::second => now;

Machine.add(me.dir() + "/mandoline.ck") => int mandolineID;


10::second => now;

Machine.remove(bassID);
Machine.remove(droleID);
Machine.remove(shitarID);
Machine.remove(mandolineID);
