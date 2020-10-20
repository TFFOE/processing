PVector randomPos() {
  return new PVector(random(left, right), random(bottom, top)); 
}

class SizeChangedException extends Exception {}
class NoFoodException extends Exception {}

void drawGrid() {
  int strip_number = 50;
  float strip_size = (right - left) / strip_number;
  
  stroke(200, 200 , 200);
  strokeWeight(1);
  for (int i = int(left / strip_size); i * strip_size < right; ++i)
    line(
      strip_size * i,
      bottom,
      strip_size * i,
      top
      );
      
  for(int i = int(bottom / strip_size); i * strip_size < top; ++i)
    line(
      left,
      strip_size * i,
      right,
      strip_size * i
      );
     
}
