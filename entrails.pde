import toxi.geom.*;

int nPoints=2000;
int lod=8;
float falloff=0;
Ball[] myPoints=new Ball[nPoints];
Vec2D myLoc;
int h_span=3;
int v_span=30;
long start=0;
int distance_threshold=40;
float jitter_x=1;
float jitter_y=1;
boolean perlin=true;
int gravity_force = 0; //set 0 for no effect

void setup() {
  start = System.currentTimeMillis()/1000;
  size(1200, 800);
  //smooth();
  background(255);
  init_noise();
  generate_balls();
}

void draw() {
  for (int i=0; i<nPoints; i++) {
    myPoints[i].update();
    if (mousePressed)
      myPoints[i].seekThis(0.1, mouseX, mouseY);
  }
  pushStyle();
  fill(0, 20);
  //rect(0, 0, width, height);
  popStyle();
  for (int i=0; i<nPoints; i++) 
    myPoints[i].lineBetween(myPoints, i+1, distance_threshold);
}

void init_noise() {
  noiseSeed((int)random(1000));
  noiseDetail(lod, falloff);
}
void generate_balls() {
  int r=45;//(int)random(55);
  int g=0;//(int)random(255);
  int b=45;//(int)random(20);
  for (int i=0; i<nPoints; i++) {
    myLoc=new Vec2D(random(width), random(height));
    myPoints[i]=new Ball(myLoc, gravity_force, h_span, v_span, jitter_x, jitter_y, perlin,r,g,b);
  }
}
void reset() {
  println("RESET");
  generate_balls();
}

void savefile() {
  long seconds=System.currentTimeMillis()/1000-start;
  String filename=nPoints+"("+lod+","+falloff+")-("+h_span+","+v_span+")"+seconds;
  save(filename+".tif");
}

void keyPressed() {
  if (key==' ')
    reset();

  if (key=='s') 
    savefile();
}