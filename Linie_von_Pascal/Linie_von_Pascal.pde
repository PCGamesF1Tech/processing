float lneu, deltal, deltawinkel;
float winkel;
float xneu, yneu, xalt, yalt;

void setup() {
  size(640,480);
  colorMode(HSB);
  frameRate(24);
}

void draw() {
  background(0);
  winkel=(30+random(120));
  lneu=2;
  deltal=2;
  deltawinkel=winkel;
  xalt=width/2;
  yalt=height/2;
  for (int i=1; i<300;i++) {
    xneu=xalt+floor(lneu*cos(PI/180*winkel));
    yneu=yalt+floor(lneu*sin(PI/180*winkel));
    stroke(random(255),255,255);
    line(xalt,yalt,xneu,yneu);
    xalt=xneu;
    yalt=yneu;
    lneu=lneu+deltal;
    winkel=winkel+deltawinkel;
  }
}
