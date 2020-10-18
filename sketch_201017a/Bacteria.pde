enum BacteriaState {
  CALM,
  PANIK
}

class Bacteria {
   static final float max_rotation_speed = 0.1;
   
   PVector pos;
   PVector translated_pos;
   float speed;
   float angle;
   color clr;
   float size;

   BacteriaState state = BacteriaState.CALM;
   PVector target;
   
   Bacteria(float x, float y, float size, float speed, float angle, color clr) {
     pos = new PVector(x, y);
     translated_pos = PVector.mult(pos, scaling);
     this.size = size;
     this.speed = speed;
     this.angle = angle;
     this.clr = clr;
   }
   
   void searchForNearestFood(Food[] food) {
     switch (state) {
       case CALM:
         target = translated_pos.copy();
             
       case PANIK:
         float min_dist = maxSearchRadius;
         int min_index = -1;
         for (int i = 0; i < food.length; ++i) {
           float line_length = food[i].pos.sub(pos).mag();
           if (line_length < min_dist) {
             min_dist = line_length;
             min_index = i;
           }
         }
         if (min_index != -1) {
           state = BacteriaState.CALM;
           target = food[min_index].pos.copy();
         }
         else {
            state = BacteriaState.PANIK;
            target = pos.copy();
         }
       break;
     }
   }
   
   void update() {
     PVector d_pos = PVector.fromAngle(angle);
     d_pos.setMag(speed);
     d_pos.mult(scaling);
     
     pos.add(d_pos);
     translated_pos = PVector.mult(pos, scaling);
   }
   
   void moveToPoint(float x, float y) {
     this.moveToPoint(new PVector(x, y)); 
   }
   
   void moveToPoint(PVector point) {
     if (PVector.dist(translated_pos, point) > 1) {
       rotateTo(point);
       update();
     }
   }
   
   void rotateTo(float x, float y) {
     this.rotateTo(new PVector(x, y));
   }
   
   void rotateTo(PVector pointToRotate) {
     PVector fromPosToPoint = pointToRotate.sub(translated_pos);
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
     stroke(0);
     strokeWeight(3);
     fill(clr);
     circle(translated_pos.x, translated_pos.y, size * scaling);
   }
}
