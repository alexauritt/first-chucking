// score.ck

// paths to chuck file
me.dir() + "/piano.ck" => string pianoPath;
me.dir() + "/chrip2.ck" => string chrip2Path;
me.dir() + "/blowhole.ck" => string blowholePath;
me.dir() + "/unclap.ck" => string unclapPath;

// Current time
now=>time cur;


    // start blowhole
    Machine.add(blowholePath) => int blowholeID;
    6.2::second => now;
    
    // start piano
    Machine.add(pianoPath) => int pianoID; 
    3.4::second => now;

    // start chrip2
    Machine.add(chrip2Path) => int chrip2ID;
    4.8::second => now;

    // start unclap solo
    Machine.add(unclapPath) => int unclapID;
    4.8::second => now;

    // remove blowhole
    Machine.remove(blowholeID);
    4.8::second => now;

    // add blowhole back in 
    Machine.add(blowholePath) => blowholeID;

    // remove chrip2
    Machine.remove(chrip2ID);
    
    // remove piano
    Machine.remove(pianoID);
    2::second => now;

    // remove blowhole
    Machine.remove(blowholeID);
    2::second => now;

    // remove unclap
    Machine.remove(unclapID);

    // add piano back in 
    Machine.add(pianoPath) =>pianoID; 
    2::second => now;
    
    // remove piano
    Machine.remove(pianoID);
    
now-cur=>dur final;
//print the total time taken
<<<"Time:",final/second>>>;