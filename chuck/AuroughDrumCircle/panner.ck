public class Panner {

  // boolean -- if 1, we are moving right, else left
  1 => int panRight;
    
  // value between -1 and 1
  // -1 is left, 1 is right, 0 is split
  0.0 => float panPosition;
  
  0.1 => float incrementValue;
  
  fun float getPanPosition() {
    if (panRight == 1) {
      if (panPosition >= 1.0) {
        0 => panRight;
      } else {
        panPosition + incrementValue => panPosition;        
      }
    } else {
      if (panPosition <= -1.0) {
        1 => panRight;
      } else {
        panPosition - incrementValue => panPosition;
      }
    }    
    return panPosition;
  }
}