int food_number = 1000;

static float scaling_base = 0.5;
float scaling = scaling_base;
float scalingSpeed = 0.05;

Bacteria b, b1, b2, b3, b4;
Bacteria[] bacterias;
ArrayList<Food> food = new ArrayList<Food>(food_number);

float right;
float left;
float top;
float bottom;

void setup() {
  //size(800, 600);
  fullScreen();
  frameRate(50);
  
  right = 2 * width;
  left = -2 * width;
  top = 2 * height;
  bottom = -2 * height;
  
  for (int i = 0; i < food_number; ++i) {
    food.add(new Food(randomPos(), random(10, 15)));
  }
  
  bacterias = new Bacteria[] { 
    b = new Bacteria(width/2 - 200, height/2, 25, 7, 0, #55ff55, 1000), 
    b1 = new Bacteria(width/2 - 400, height/2, 25, 7, 0, #55ff55, 1200),
    b2 = new Bacteria(width/2 - 600, height/2, 25, 7, 0, #55ff55, 400),
    b3 = new Bacteria(width/2 + 200, height/2, 25, 7, 0, #55ff55, 600),
    b4 = new Bacteria(width/2 + 400, height/2, 25, 7, 0, #55ff55, 200)
  };
}

float old_scaling = 1;
float new_scaling = 1;
boolean scale_animate = false;
static int scale_frames = 50;
int scale_counter = 0;

float translate_x = 0;
float translate_y = 0;
float mouse_x_old = mouseX;
float mouse_y_old = mouseY;

void draw() {
  background(255); 
  
  if (mousePressed) {
    float dx = mouseX - mouse_x_old;
    float dy = mouseY - mouse_y_old;
    translate_x += dx;
    translate_y += dy;
  }
  
  if (scale_animate == true) {
    scaling = lerp(old_scaling, new_scaling, float(scale_counter) / scale_frames);
    
    ++scale_counter;
    if (scale_counter == scale_frames)
      scale_animate = false;
  }
  
  translate(width / 2 + translate_x, height / 2 + translate_y);
  translate(-b.pos.x * scaling, -b.pos.y * scaling);
  scale(scaling);
  
  rectMode(CORNERS);
  noFill();
  stroke(0);
  strokeWeight(3);
  rect(left, top, right, bottom);
  
  drawGrid();
  
  try {
    b.moveToNearestFood();
  }
  catch (SizeChangedException e) {
    //scale_counter = 0;
    //scale_animate = true;
    //new_scaling = 25 / b.size * scaling_base;
    //old_scaling = scaling;
  }
  
  try {
    for (int i = 1; i < bacterias.length; ++i)
      bacterias[i].moveToNearestFood(); //<>//
  }
  catch (Exception e) {}
    
  for (Food f : food) {
    if (!f.eaten) f.draw();
  }
  for (Bacteria b: bacterias) {
    b.draw();
  }
  
  
  mouse_x_old = mouseX;
  mouse_y_old = mouseY;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0) {
    scaling -= scalingSpeed;
    if (scaling <= 0)
      scaling = 0;
  }
  else if (e < 0) {
  scaling += scalingSpeed;
  }
}
