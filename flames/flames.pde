import java.awt.Color;
//import java.awt.Graphics;

int[][] fire;
int[][] cool;
int scale = 3;
int w, h;
PImage Buffer;
PImage cooling;

int cols, rows;
color c;

float xoff = 0;
float yoff = 0;
float ystart = 0;

void setup() {
  size(600, 600, FX2D);
  //fullScreen();
  w= width;
  h = height;
  cols = int(w / scale);
  rows = int(h / scale);
  colorMode(HSB, 255, 255, 255);
  fire = new int[cols][rows];
  cooling();
}

void cooling() {
  cool = new int[width][height];
  for (int x=0; x< width; x++) {
    xoff += 0.01;
    for (int y=0; y< height; y++) {
      float n = noise(xoff, yoff)*10;
      if (n < 0.4) {
        n=0;
      }
      cool[x][y] = int(n);
      yoff += ystart;
    }
  }
  //ystart += 2;
}

void draw() {
  background(0);
  //cooling();

  //randomize bottom row
  for (int x=0; x < cols; x++) {
    float val = random(0,1);
    if (val <= 0.5) {
      val = 0;
    } else {
      val=99;
    }
    fire[x][rows-1] = floor(val);
  }

  for (int y=0; y < rows; y++) {
    for (int x=0; x < cols; x++) {

      //recalc value at x,y
      fire[x][y] = ((fire[(x-1+cols) % cols][(y+1) % rows]
        +  fire[(x) % cols][(y+1) % rows]
        +  fire[(x+1) % cols][(y+1) % rows])) /3 -1;
        
        //+  fire[(x) % cols][(y+2) % rows]) * 40 / 165;

      //paint
      noStroke();
      float f = fire[x][y] - cool[x][y];
      fill(f, 255, map(f, 0, 20, 0, 255));
      rect(x * scale, y * scale, scale, scale);
    }
  }
}