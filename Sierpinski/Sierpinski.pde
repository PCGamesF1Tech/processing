float Laenge = 800;
float LX = width / 5;
float LY = height - 10;
float RX = LX + int(Laenge);
float RY = LY;
float TX = LX + Laenge / 2;
float TY = LY - sin(60 * PI / 180) * Laenge;
float StartX = 400; //random(width);
float StartY = 200; //random(height);
int wuerfel;

void setup() {
  size(800, 600);
  background(0);
}

void draw() {

for (int n=0; n < 100; n++) {
  translate(width/2, height/2);


  wuerfel = int(random(1, 4));
  //println(wuerfel);

  if (wuerfel == 1) {
    StartX = (StartX + LX) / 2;
    StartY = (StartY + LY) / 2;
    stroke(255, 0, 0);
  }
  if (wuerfel == 2) {
    StartX = (StartX + TX) / 2;
    StartY = (StartY + TY) / 2;
    stroke(0, 255, 0);
  }
  if (wuerfel == 3) {
    StartX = (StartX + RX) / 2;
    StartY = (StartY + RY) / 2;
    stroke(0, 0, 255);
  }
  //fill(255);
  point(StartX, StartY);
  //ellipse(StartX,StartY,3,3);
}
}