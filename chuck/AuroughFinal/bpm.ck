public class BPM {
  dur myDuration[4];
  static dur measure, wholeNote, halfNote, quarterNote, triplet, eighthNote, eighthTriplet, sixteenthNote, sixteenthTriplet, thirtySecondNode;
  
  fun void tempo(float beat) {
    60.0 / (beat) => float SPB;
    SPB::second => quarterNote;    
//    quarterNote * 3 => measure;
    quarterNote * 4 => wholeNote;
    quarterNote * 2 => halfNote;
    quarterNote * 0.5 => eighthNote;
    quarterNote / 3 => triplet;
    eighthNote * 0.5 => sixteenthNote;
    eighthNote / 3 => eighthTriplet;
    eighthNote / 3 => sixteenthTriplet;
    sixteenthNote * 0.5 => thirtySecondNode;
  }
}