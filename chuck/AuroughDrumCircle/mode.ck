public class Mode {  

  // D Dorian scale
//  [50.0, 52.0, 53.0, 55.0, 57.0, 59.0, 60.0, 60.2]  @=> float myScale[];
  
  // Eb Mixolydian
//  [51.0, 53.0, 55.0, 56.0, 58.0, 60.0, 61.0, 63.0]  @=> float myScale[];
  
  // C Ionian scale
  [48.0, 50.0, 52.0, 53.0, 55.0, 57.0, 59.0, 60.0]  @=> float myScale[];
  
  // play central octave
  fun float getTone(int interval) {
    return Std.mtof(myScale[interval]);
  }
  
  // overloaded function: 2nd parameter can raise or lower octave
  // use octave == -1 to drop down one octave, 
  // or use 2 to raise 2 octaves, etc.
  fun float getTone(int interval, int octave) {
    return Std.mtof(myScale[interval] + octave * 12);
  }  
}