class Ball {

  Vec2D pos;
  Vec2D speed;
  float d=50;
  float dx, dy;
  float maxSpeed=1.5;
  int r=45;
  int g=0;
  int b=45;
  Ball(Vec2D pos) {
    this.pos=pos;
    dx=random(20, d);
    dy=dx;
    this.speed=new Vec2D(random(-3, 3), random(-3, 3));
  }

  void update() {
    moveNoise();
    //    moveRandom();
    //    move();
    //bounce();
    //display();
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

  void move() {
    speed.limit(maxSpeed);
    pos.addSelf(speed);
    //  pos.jitter(1);
  }

  void moveRandom() {
    pos.x+=random(-maxSpeed, maxSpeed);
    pos.y+=random(-maxSpeed, maxSpeed);
  }

  void moveNoise() {
    pos.x+=cos(noise(pos.x*0.01, pos.y*0.01)*TWO_PI)*0.1;
    pos.y+=sin(noise(pos.x*0.01, pos.y*0.01)*TWO_PI);
  }

  void wrap() {
    if (pos.x<0) pos.x=width;
    if (pos.x>width) pos.x=0;
    if (pos.y<0) pos.y=height;
    if (pos.y>height) pos.y=0;
    
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

  void display() {
    pushStyle();
    noStroke();
    float c=map(speed.magnitude(), 0, maxSpeed, 0, 255);
    fill(255, 255-c, 255-c, 50);
    ellipse(pos.x, pos.y, dx, dy);
    popStyle();
  }

  void seekThis(float strength, float x, float y) {
    Vec2D follow=new Vec2D(x, y);
    follow.subSelf(pos);
    if (follow.magnitude()<200) {
      follow.normalizeTo(strength);
      speed.addSelf(follow);
    }
  }

  void bounce() {
    if (pos.x<=0 || pos.x>=width)
      speed.x*=-1;
    if (pos.y<=0 || pos.y>=height)
      speed.y*=-1;
  }
}