class Ball {

  Vec2D pos;
  Vec2D speed;
  float d=50;
  float dx, dy;
  float maxSpeed=1;
  int gravity_force;
  float jitter_x, jitter_y;
  float line_width=0.6;
  int r,g,b;
  boolean perlin; //shall make correction based on perlin-noise?

  Ball(Vec2D pos, int gravity_force, int h_span, int v_span, float jitter_x, float jitter_y, boolean perlin, int r, int g, int b) {
    this.gravity_force=gravity_force;
    this.pos=pos;
    this.jitter_x=jitter_x;
    this.jitter_y=jitter_y;
    this.r=r;
    this.g=g;
    this.b=b;
    dx=random(20, d);
    dy=random(20, d);
    if (perlin) {
      float n = noise(pos.x,pos.y);
      this.speed=new Vec2D(random(-h_span, h_span)*n, random(-v_span, v_span)*n);
    } else {
      this.speed=new Vec2D(random(-h_span, h_span), random(-v_span, v_span+gravity_force));
    }
  }

  void update() {
    move();
    //bounce();
    //display();
    //displayPoint();
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
    float adj_x=1;
    float adj_y;
    if (perlin) {
      adj_x=noise(pos.x, pos.y);
      adj_y=adj_x;
    }
    adj_y=adj_x;
    Vec2D newspeed=new Vec2D(speed.x*adj_x, speed.y*adj_y);
    newspeed.limit(maxSpeed);
    pos.addSelf(newspeed);
  }

  void wrap() {
    if (pos.x<0) pos.x=random(width);
    if (pos.x>width) pos.x=random(width);
    if (pos.y<0) pos.y=random(height);
    if (pos.y>height) pos.y=random(height);
  }

  void lineBetween(Ball[] theOthers, int start, float th) {
    for (int i=start; i<theOthers.length; i++) {
      if (pos.distanceTo(theOthers[i].pos)<th) {
        pushStyle();
        strokeWeight(line_width);
        stroke(r, g, b, 5);
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