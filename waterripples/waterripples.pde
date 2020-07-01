float g = 0.5;  // gravity
float friction = g / 2;  // gravity divided by 2 gives ok results
short Watersize = 600;   // try bigger windowsizes
float a, vs, hgtSurr, hgtDiff, hgtNew;   //  acceleration, vertical speed, results for height field
float [][] h = new float[Watersize][Watersize];   // two dim array for height at (x,y)
float [][] v = new float[Watersize][Watersize];   // two dim array for speed at (x,y)
int scl = 3;

void setup() {
  size(600,600);
  for (int y = 0; y < Watersize / scl; y += scl) {
    for (int x = 0; x < Watersize / scl; x += scl) {
      h[x][y] = 255;
      v[x][y] = random(-30, 30);
    }
  }
  loadPixels();
  cursor(CROSS);
  log(a);
}


void CalcWaves() {
  for (int y = 1; y < Watersize-1 / scl; y += scl) {
    for (int x = 1; x < Watersize-1 / scl; x += scl) {

      // calc average height of surrounding spots
      hgtSurr = (h[x-1][y] + h[x+1][y] + h[x][y-1] + h[x][y+1]) / 4.0;

      // calc difference of actual and average
      hgtDiff = hgtSurr - h[x][y];

      // add gravity
      a = hgtDiff * g;

      // calc speed v = v0 + a * t
      vs = v[x][y] * (1 - friction) + a;

      // new height = height + vertical speed of wave vs
      hgtNew = h[x][y] + vs;

      // set new height on actual position
      h[x][y] = hgtNew;
      v[x][y] = vs;
    }
  }
}


void drawWaves() {
  for (int x = 0; x < width - 1 / scl; x+=scl) {
    for (int y = 0; y < height - 1 / scl; y+=scl) {
      int loc = x + y * width;
      pixels[loc] = color(50, 50, int(h[x][y]));
    }
  }
  updatePixels();
}


void draw() {
  CalcWaves();
  drawWaves();
  if (mousePressed == true) {
    h[mouseX][mouseY] += 15000;
  }
}