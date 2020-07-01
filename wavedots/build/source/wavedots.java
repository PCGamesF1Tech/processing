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

public class wavedots extends PApplet {

Dot[] dots = new Dot[800];

public void setup() {
  
  colorMode(HSB);
  //blendMode(ADD);
  for (int i=0; i < dots.length; i++) {
    dots[i] = new Dot();
  }
}

public void draw(){
  background(51);
  for (int i=0; i<dots.length;i++) {
    dots[i].update();
    dots[i].display();
    dots[i].edge();
  }
}
class Dot {

  PVector pos;
  PVector vel;
  PVector acc;
  float r;
  float col;
  float xoff=0.1f;
  float alpha=255;

  Dot() {
    pos = new PVector(random(width/10), random(height));
    r = random(20,80);
    vel = new PVector(random(1,6), random(-0.3f, 0.3f));

    col=random(255);
  }

  public void update() {
    pos.y += 1.1f * sin(pos.x/r*0.15f) + cos(-pos.x/r*0.75f);
    pos.add(vel);
  }

  public void display() {
    noStroke();
    fill(col, 255, 255, 200);
    ellipse(pos.x, pos.y, r, r);
  }

  public void edge() {
    if (pos.x > width+r || pos.y < -r || pos.y > height + r) {
      r = random(20, 80);
      pos.x = -r;
      pos.y = random(height);
      vel = new PVector(random(1,6), random(-0.3f, 0.3f));
      col = random(255);
    }
  }
}
  public void settings() {  size(1200,800,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "wavedots" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
