// score.ck
/**
 * Coursera.org
 * "Introduction to Programming for Musicians and Digital Artists "
 * Assignment 6 "Bass, Drums and Clarinet"
 * 
 * date: 2013.12.01
 */

Machine.add(me.dir() + "/drums.ck") => int drumID;

5::second => now;

Machine.add(me.dir() + "/bass.ck") => int bassID;

5::second => now;

Machine.add(me.dir() + "/clarinet.ck") => int clarinetID;

10::second => now;

Machine.remove(clarinetID);

5::second => now;

Machine.remove(drumID);

5::second => now;

Machine.remove(bassID);
