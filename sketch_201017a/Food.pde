class Food {
  PVector pos;
  float size;
  color clr = #0000ff;
  boolean eaten = false;
  
  Food(PVector pos, float size) {
    this(pos.x, pos.y, size); 
  }
  
  Food(float x, float y, float size) {
    pos = new PVector(x, y);
    this.size = size;
  }
  
  void draw() {
    noStroke();
    fill(clr);
    circle(pos.x, pos.y, size * 2); 
  }
}
