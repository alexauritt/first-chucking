public class BPM {
  dur myDuration[4];
  dur quarterNote, eighthNote, sixteenthNote, thirtySecondNode;
  
  fun void tempo(float beat) {
    60.0 / (beat) => float SPB;
    SPB::second => quarterNote;
    quarterNote * 0.5 => eighthNote;
    eighthNote * 0.5 => sixteenthNote;
    sixteenthNote * 0.5 => thirtySecondNode;
    
    [quarterNote, eighthNote, sixteenthNote, thirtySecondNode] @=> myDuration;
  }
}