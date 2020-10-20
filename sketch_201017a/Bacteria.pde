class Bacteria {
   static final float max_rotation_speed = 0.45;
   
   PVector pos;
   float speed;
   float angle;
   color clr;
   float size;
   float searchDistance = 400;
   
   // 0 - режим ожидания
   // 1 - движение к еде
   int mode = 0;
   Food target;
   int target_index = -1;
   
   Bacteria(float x, float y, float size, float speed, float angle, color clr, float searchDistance) {
     this(x, y, size, speed, angle, clr);
     this.searchDistance = searchDistance;
   }
   
   Bacteria(float x, float y, float size, float speed, float angle, color clr) {
     pos = new PVector(x, y);
     this.size = size;
     this.speed = speed;
     this.angle = angle;
     this.clr = clr;
   }
   
   void update() {
     PVector d_pos = PVector.fromAngle(angle);
     d_pos.setMag(speed);
     
     pos.add(d_pos);
   }
   
   void moveToPoint(float x, float y) {
     this.moveToPoint(new PVector(x, y)); 
   }
   
   void moveToPoint(PVector point) {
     if (PVector.dist(pos, point) > 0.5) {
       rotateTo(point);
       update();
     }
   }
   
   void rotateTo(float x, float y) {
     this.rotateTo(new PVector(x, y));
   }
   
   void rotateTo(PVector pointToRotate) {
     PVector fromPosToPoint = PVector.sub(pointToRotate, pos);
     float pointDirection = fromPosToPoint.heading();
     float rotateTo = pointDirection - this.angle;
     
     if (rotateTo < - PI)
       rotateTo += 2 * PI;
     else if (rotateTo > PI)
       rotateTo -= 2 * PI;
     
     if (rotateTo > 0.01) {
       this.rotate(max_rotation_speed);
     }
     else if (rotateTo < -0.01) {
       this.rotate(-max_rotation_speed);
     }
   }
   
   boolean targetReached() {
     float reachDistance = this.size / 2;
     return this.pos.dist(target.pos) < reachDistance;
   }
   
   void moveToNearestFood() throws SizeChangedException {
     if (target != null && target.eaten) {
       target = null;
       target_index = -1;
       mode = 0;
       return;
     }
     
     if (mode == 0) {
       try {
         target = searchForNearestFood(food); //<>//
       }
       catch (NoFoodException ex) {
         textAlign(CENTER, CENTER);
         textSize(30);
         fill(#ff0000);
         text("Еда закончилась :с", pos.x, pos.y - 40);
       }
       
       if (target != null) {
         mode = 1;
       }
     }
     else if (mode == 1) { // Moving to target
       moveToPoint(target.pos);
       if (targetReached()) {
         size += food.get(target_index).size / 30;
         // speed -= 0.03;
         mode = 0;
         
         food.get(target_index).eaten = true;
         
         target_index = -1;
         target = null;
         throw new SizeChangedException();
       }
     }
   }
   
   Food searchForNearestFood(ArrayList<Food> foods) throws NoFoodException {
     float min_distance = searchDistance;
     Food nearest = null;
     target_index = -1;
     target = null;
     
     for (int i = 0; i < foods.size(); ++i) {
       Food current_food = foods.get(i);
       
       if (current_food.eaten) {
         continue;
       }
       
       float current_distance = PVector.dist(this.pos, current_food.pos);
       if (current_distance < this.searchDistance/2 && current_distance < min_distance) {
         nearest = current_food;
         target_index = i;
         min_distance = current_distance;
       }
     }
     
     if (nearest != null)
       nearest.clr = #ff0000;
     else
       throw new NoFoodException();
     return nearest;
   }
   
   void rotate(float d_angle) {
      angle += d_angle;
      if (angle > PI)
        angle -= 2 * PI;
      else if (angle < - PI)
        angle += 2 * PI;
        
   }
   
   void rotate() {
     this.rotate(max_rotation_speed); 
   }
   
   void draw() {
     noStroke();
     fill(127, 127, 127, 50);
     circle(pos.x, pos.y, searchDistance);
     
     stroke(0);
     strokeWeight(3);
     fill(clr);
     circle(pos.x, pos.y, size);
   }
}
