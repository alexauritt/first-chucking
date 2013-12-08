public class Mode {  
  // C Ionian Mode
  [48.0, 50.0, 52.0, 53.0, 55.0, 57.0, 59.0, 60.0]  @=> float myScale[];
  
  fun float getTone(int interval) {
    return Std.mtof(myScale[interval]);
  }
  
  fun float getTone(int interval, int octave) {
    return Std.mtof(myScale[interval] + octave * 12);
  }
  
  fun void sayHi() {
    <<< "hi from mode" >>>;
  }
}