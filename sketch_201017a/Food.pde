class Food {
  PVector pos;
  float size;
  
  Food(PVector pos, float size) {
    this(pos.x, pos.y, size); 
  }
  
  Food(float x, float y, float size) {
    pos = new PVector(x, y);
    this.size = size;
  }
  
  void draw() {
    noStroke();
    fill(#ffff00);
    circle(pos.x * scaling, pos.y * scaling, size * scaling); 
  }
}
