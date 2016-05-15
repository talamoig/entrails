class Ball {

  Vec2D pos;
  Vec2D speed;
  float d=50;
  float dx, dy;
  float maxSpeed=1.5;
  int r=20;
  int g=0;
  int b=70;
  Ball(Vec2D pos) {
    this.pos=pos;
    dx=random(20, d);
    dy=dx;
    this.speed=new Vec2D(random(-3, 3), random(-3, 3));
  }

  void update() {
    moveNoise();
  
    displayPoint();
    wrap();
  }

  void displayPoint() {
    pushStyle();
    stroke(0, 20);
    //stroke(abs(sin(frameCount/100.0))*255, 0, 0, 255);
    strokeWeight(0.5);
    point(pos.x, pos.y);
    popStyle();
  }

  void moveNoise() {
    pos.x+=cos(noise(pos.x*0.01, pos.y*0.01)*TWO_PI)*0.1;
    pos.y+=sin(noise(pos.x*0.01, pos.y*0.01)*TWO_PI);
  }

  void wrap() {
    if (pos.x<0 || pos.x>width) pos.x=random(width);
    if (pos.y<0 || pos.y>height) pos.y=random(height);
  }

  void lineBetween(Ball[] theOthers, int start, float th) {
    for (int i=start;i<theOthers.length;i++) {
      if (pos.distanceTo(theOthers[i].pos)<th) {
        pushStyle();
        strokeWeight(0.5);
        //stroke(50,5,50,5);
        stroke(r,g,b,5);
        line(pos.x, pos.y, theOthers[i].pos.x, theOthers[i].pos.y);
        popStyle();
      }
    }
  }
}