// score.ck
// Score part


Machine.add(me.dir() + "/piano.ck") => int pianoID;
2.5::second => now;
Machine.add(me.dir() + "/bass.ck") => int bassID;
5.0::second => now;
Machine.add(me.dir() + "/drums.ck") => int drumID;
2.5::second => now;
Machine.add(me.dir() + "/flute.ck") => int fluteID;
10.0::second => now;
Machine.remove(fluteID);
5.0::second => now;
Machine.remove(drumID);
2.5::second => now;
Machine.remove(pianoID);
2.5::second => now;
Machine.remove(bassID);
