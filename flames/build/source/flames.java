import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.Color; 
import java.awt.Graphics; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class flames extends PApplet {

//import peasy.*;



int[][] fire;
int scale = 5;
int w, h;
int cols, rows;
int[] pal = new int[256];
int c;
//PeasyCam cam;

public void setup() {
  
  //cam = new PeasyCam(this,250);
  w = width;
  h = height;
  cols = PApplet.parseInt(w / scale);
  rows = PApplet.parseInt(h / scale);
  println(cols, rows);
  colorMode(HSB, 255, 255, 255);
  for (int i=0; i < 256; i++) {
    pal[i] = Color.HSBtoRGB(i/3, 255, min(255, i*2));
  }
  fire = new int[cols][rows];
}

public void draw() {
  background(0);

  //randomize bottom row
  for (int x=0; x < cols; x++) fire[x][rows-1] = round(random(90));

  for (int y=0; y < rows; y++) {
    for (int x=0; x < cols; x++) {

      //recalc value at x,y
      fire[x][y] = ((fire[(x-1+cols) % cols][(y+1) % rows]
        +  fire[(x) % cols][(y+1) % rows]
        +  fire[(x+1) % cols][(y+1) % rows]
        +  fire[(x) % cols][(y+2) % rows]) * 40) /161;

      //paint
      noStroke();
      int f = fire[x][y];
      fill(f,255,map(f,0,20,0,255));
      rect(x * scale, y * scale, scale, scale);
    }
  }
}
  public void settings() {  size(800,400,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "flames" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
