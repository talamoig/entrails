import toxi.geom.*;
int lod=8;
float falloff=0;
int nPoints=2000;
Ball[] myPoints=new Ball[nPoints];
Vec2D myLoc;
long start;
void setup() {
  size(800, 800);
  start = System.currentTimeMillis()/1000;
  smooth();
  noiseSeed(round(random(1000)));
  //noiseSeed(0);
  noiseDetail(lod, falloff);
  //Vec2D speed=new Vec2D(random(-3, 3), random(-3, 3));
  for (int i=0;i<nPoints;i++) {
    myLoc=new Vec2D(random(width), random(height));
    myPoints[i]=new Ball(myLoc);
  }
  background(255);
}

void draw() {

  for (int i=0;i<nPoints;i++) 
    myPoints[i].update();
  
  pushStyle();
  fill(0, 20);
  popStyle();
  for (int i=0;i<nPoints;i++) 
    myPoints[i].lineBetween(myPoints, i+1, 40);
}

void savefile(){

  long seconds=System.currentTimeMillis()/1000-start;                                                                                                           
  String filename=nPoints+"("+lod+","+falloff+")-"+seconds;                                                                              
  save(filename+".tif");                                                                                                                                        
}
void keyPressed() {
  if (key==' ') {
  for (int i=0;i<nPoints;i++) {
    myPoints[i].pos.x=random(width);
    myPoints[i].pos.y=random(height);
  }}
  
  if (key=='s'){
  savefile();
  }
}