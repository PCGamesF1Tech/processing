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

public class lunar_lander extends PApplet {

//import processing.sound.*;

Lander ldr;
FuelGauge fuelMeter;

Stars[] stars = new Stars[100];

//PImage imgEarth;

public void setup() {
  

  //imgEarth = loadImage("erde.png");

  ldr = new Lander(width/2, height/2);
  fuelMeter = new FuelGauge();

  for (int i=0; i < stars.length; i++) {
    stars[i] = new Stars();
  }

}

public void draw() {
  // dark blue space
  background(0, 0, 50);

  //basic data
  showData();

  //fuel meter
  fuelMeter.show();

  // draw earth & stars
  showDecorations();

  //update lander acc, vel, pos etc.

  ldr.update();
  ldr.display();
}


public void showDecorations() {
  //image(imgEarth, width-width/3, height-height*2/3, 250, 200);
  showStars();
}

public void showStars() {
  for (int i=0; i <
    stars.length; i++) {
    stars[i].show();
    stars[i].update();
  }
}

public void showData() {
  textSize(16);
  fill(255);
  text("Fuel " + nf(ldr.fuel, 4, 1) + " kg", 10, 20);
  text("Hght " + nf(ldr.hgtAGL, 4, 1) + " m", 10, 40);
  text("vert " + nf(-ldr.vel.y, 2, 2) + " m/s", 10, 60);
  text("horz " + nf(ldr.vel.x, 2, 2) + " m/s", 10, 80);
  text(frameRate, width-50, 20);
  println(ldr.rotation);
}

public void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      ldr.thrusterOn();
      break;
    case LEFT:
      ldr.turnR(false);
      break;
    case RIGHT:
      ldr.turnR(true);
      break;
    }
  }
}

public void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      ldr.thrusterOff();
    }
  }
}

// W I P - midpoint displacement terrain
//
// void terrain(float width, float height, float displace, float roughness) {
//
//   int power;
//   // Gives us a power of 2 based on our width
//   power = round(pow(2, round(log(width) / (log(4)))));
//
//   // Set the initial left point
//   points[0] = height/2 + (random(1)*displace*2) - displace;
//   // set the initial right point
//   points[power] = height/2 + (random(1)*displace*2) - displace;
//   displace *= roughness;
//
//   // Increase the number of segments
//   for (int i = 1; i < power; i *=2) {
// Iterate through each segment calculating the center point
//     for (int j = (power/i)/2; j < power; j+= power/i) {
//       points[j] = ((points[j - (power / i) / 2] + points[j + (power / i) / 2]) / 2);
//       points[j] += (random(1)*displace*2) - displace;
//     }
//     // reduce our random range
//     displace *= roughness;
//   }
//   //return points;
// }
class FuelGauge {

  public void show() {
    textSize(20);
    int textPosX = width/2 - 150;
    int tank = PApplet.parseInt(ldr.fuel);
    if (tank >= 1775) {
      fill(0, 255, 0);
    } else if (tank < 1775 && tank > 650) {
      fill(255, 255, 0);
    } else if (tank < 650) {
      fill(255, 0, 0);
    }
    text("FUEL", width/2 - textWidth("FUEL")/2, 30);
    
    // fuel amount
    strokeWeight(10);
    stroke(255, 0, 0);
    line(textPosX, 50, textPosX+40, 50); // red band
    stroke(255, 255, 0);
    line(textPosX+40, 50, textPosX+110, 50); // yellow band
    stroke(0, 255, 0);
    line(textPosX+110, 50, textPosX+302, 50); // green band
    
    // fuel needle
    float needlepos = map(ldr.fuel, 0, 5000, textPosX, textPosX+301);
    stroke(255);
    strokeWeight(3);
    line(needlepos, 40, needlepos, 60);
  }
}
class Lander { //<>//

  PVector pos;
  PVector vel;
  PVector acc;
  PVector thr;
  PVector hdg;

  float rotation = PI/2;
  float heading;
  float thrust = 0.2f;
  float hgtAGL;

  float mass = 10000;
  float fuel = 5000;
  float grossWeight;
  PVector gravity = new PVector(0, 0.016f);

  int size = 60;

  boolean landed = false;
  boolean thruster = false;

  PImage imgLander;

  //constructor
  Lander(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    thr = new PVector(0,-thrust);
    hdg = new PVector(0,0);
    rotation = hdg.heading();

    imgLander = loadImage("lander.png");
  }

  public void applyForce(PVector force) {
    gravity.mult(grossWeight);
    PVector f = PVector.div(force, grossWeight);
    acc.add(f);
  }

  public void turnR(boolean dir) {
    fuel -= 0.5f;
    if (dir) {
      rotation += PI/40;
      thr.rotate(PI/40);
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(rotation); // for steering thruster
      fill(255);
      ellipse(-25, -18, 15, 5);
      popMatrix();
    } else {
      rotation -= PI/40;
      thr.rotate(-PI/40);
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(rotation); // for steering thruster
      fill(255);
      ellipse(18, -18, 15, 5);
      popMatrix();
    }
  }

  public void thrusterOn() {
    if (fuel > 0) {
      acc.add(thr);
      fuel -= 5;
      thruster=true;
    }
  }

  public void thrusterOff() {
    thruster = false;
  }

  public void checkEdges() {

    if (pos.x > width + size) {
      pos.x = -size;
    } else if (pos.x < 0 - size) {
      pos.x = width + size;
    }
    if (hgtAGL == 0) {
      landed = true;
    }
  }

  public void update() {
    acc.add(gravity);
    vel.add(acc);
    //vel.limit(40);
    pos.add(vel);
    vel.mult(0.998f);
    acc.mult(0);

    grossWeight = mass + fuel;
    hgtAGL = abs(height - pos.y);
    checkEdges();
  }

  public void display() {
    pushMatrix();
    noStroke();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(rotation);
    image(imgLander, 0, 0, size, size);
    if (thruster) {
      fill(255, 255, 0);
      ellipse(0, 40, 15, 25);
      fill(255, 0, 0);
      ellipse(0, 40, 5, 15);
    }
    popMatrix();
  }
}
//for particle effects like thruster, explosion when crashing etc.
class Particle {

  PVector ppos;
  PVector pvel;
  float lifetime;

  Particle(float x_, float y_) {
    ppos = new PVector(x_,y_);
    pvel = new PVector(random(-0.5f, 0.5f), random(1, 3));
    lifetime = 255;
  }

  public void update() {
    ppos.add(pvel);
    lifetime -= 10;
  }

  public boolean isDead() {
    if (lifetime <= 0) {
      return true;
    } else {
      return false;
    }
  }

  public void show() {
    fill(200, 200, lifetime);
    ellipse(ppos.x, ppos.y, 5,5);
  }
}
class Stars {

  float x;
  float y;
  float xSpd;
  float col;

  Stars() {
    x = random(width);
    y = random(height-30);
    col = random(100, 255);
  }

  public void update() {
    xSpd = -ldr.vel.x/100;
    x += xSpd;
    if (x > width) {
      x = 0;
    } else if (x < 0) {
      x = width;
    }
  }

  public void show() {
    stroke(col);
    strokeWeight(1);
    point(x, y);
  }
}
  public void settings() {  size(1200, 800,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "lunar_lander" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
