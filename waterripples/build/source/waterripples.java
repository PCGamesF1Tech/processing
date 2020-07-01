import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class waterripples extends PApplet {

float g = 0.5f;  // gravity
float friction = g / 2;  // gravity divided by 2 gives ok results
short Watersize = 600;   // try bigger windowsizes
float a, vs, hgtSurr, hgtDiff, hgtNew;   //  acceleration, vertical speed, results for height field
float [][] h = new float[Watersize][Watersize];   // two dim array for height at (x,y)
float [][] v = new float[Watersize][Watersize];   // two dim array for speed at (x,y)


public void setup() {
  
  for (int y = 0; y < Watersize; y++) {
    for (int x = 0; x < Watersize; x++) {
      h[x][y] = 255;
      v[x][y] = random(-30, 30);
    }
  }
  loadPixels();
  cursor(CROSS);
  log(a);
}


public void CalcWaves() {
  for (int y = 1; y < Watersize-1; y++) {
    for (int x = 1; x < Watersize-1; x++) {

      // calc average height of surrounding spots
      hgtSurr = (h[x-1][y] + h[x+1][y] + h[x][y-1] + h[x][y+1]) / 4.0f;

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


public void drawWaves() {
  for (int x = 0; x < width - 1; x++) {
    for (int y = 0; y < height - 1; y++) {
      int loc = x + y * width;
      pixels[loc] = color(50, 50, PApplet.parseInt(h[x][y]));
    }
  }
  updatePixels();
}


public void draw() {
  CalcWaves();
  drawWaves();
  if (mousePressed == true) {
    h[mouseX][mouseY] += 15000;
  }
}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "waterripples" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
