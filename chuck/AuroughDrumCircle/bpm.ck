public class BPM {
  dur myDuration[4];
  static dur wholeNote, halfNote, quarterNote, eighthNote, sixteenthNote, thirtySecondNode;
  
  fun void tempo(float beat) {
    60.0 / (beat) => float SPB;
    SPB::second => quarterNote;    
    quarterNote * 4 => wholeNote;
    quarterNote * 2 => halfNote;
    quarterNote * 0.5 => eighthNote;
    eighthNote * 0.5 => sixteenthNote;
    sixteenthNote * 0.5 => thirtySecondNode;
        
    [quarterNote, eighthNote, sixteenthNote, thirtySecondNode] @=> myDuration;
    
    checkMath();
  }
  
  fun void checkMath() {
    if (quarterNote == 0.625::second) {
      <<< "math was correct -- quarter note is 0.625 seconds" >>>;
    } else {
      <<< "ERROR! -- quarter note is not equal to 0.625 seconds" >>>;
    }  
  }
}