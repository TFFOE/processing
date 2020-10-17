class Bacteria {
   static final float max_rotation_speed = 0.1;
   
   PVector pos;
   float speed;
   float angle;
   color clr;
   float size;
   
   
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
     d_pos.mult(scaling);
     
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
     PVector fromPosToPoint = pointToRotate.sub(pos);
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
     circle(pos.x * scaling, pos.y * scaling, size * scaling);
   }
}
