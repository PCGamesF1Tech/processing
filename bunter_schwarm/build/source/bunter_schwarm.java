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

public class bunter_schwarm extends PApplet {

PVector[] location;
PVector[] velocity;
int[] pigment;
float gravity = 0.03f;
float damping = 0.005f;

public void setup(){
  
  ellipseMode(CENTER);
  
  noStroke();
  location = new PVector[500];
  velocity = new PVector[location.length];
  pigment = new int[location.length];
  for(int i=0;i<location.length;i++){
    location[i] = new PVector(random(0,width),random(0,height));
    velocity[i] = new PVector(random(-1,1),random(-1,1));
    pigment[i] = color(random(0,255),random(0,255),random(0,255));
  }
  mouseX = width/2;
  mouseY = height/2;
  background(0);
}

public void draw(){
  fill(0,16);
  rect(0,0,width,height);
  PVector mouse = new PVector(mouseX,mouseY);
  for(int i=0;i<location.length;i++){
    fill(pigment[i]);
    ellipse(location[i].x,location[i].y,3,3);
    location[i].add(velocity[i]);
    PVector relativeLocation = PVector.sub(location[i],mouse);
    float forceMagnitude = gravity/sq(relativeLocation.mag());
    forceMagnitude = constrain(forceMagnitude,0,1);
    relativeLocation.normalize();
    velocity[i].sub(PVector.mult(relativeLocation,gravity));
    velocity[i].mult(1-damping);
    velocity[i].add(PVector.mult(new PVector(random(-1,1),random(-1,1)),0.1f));
  }
}
  public void settings() {  size(800,600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "bunter_schwarm" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
