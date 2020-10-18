int food_number = 300;
float scaling = 1.0;
float scalingSpeed = 0.03;
float maxSearchRadius = 20;

Bacteria b;
Food[] food = new Food[food_number];

float right;
float left;
float top;
float bottom;

void setup() {
  size(800, 600);
  
  right = 2 * width;
  left = -2 * width;
  top = 2 * height;
  bottom = -2 * height;
  
  for (int i = 0; i < food_number; ++i) {
    food[i] = new Food(randomPos(), random(10, 15));
  }
  b = new Bacteria(width/2, height/2, 25, 2, 0, #55ff55);
}

void draw() {
  background(255);
  
  for (Food f : food) {
    f.draw();
  }
  
  b.moveToPoint(mouseX, mouseY);  
  b.draw();
  println(scaling);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0) {
    scaling -= scalingSpeed;
  }
  else if (e < 0) {
    scaling += scalingSpeed;
  }
}
