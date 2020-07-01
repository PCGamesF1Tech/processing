class Lander { //<>//

  PVector pos;
  PVector vel;
  PVector acc;
  PVector thr;
  PVector hdg;

  float rotation = PI/2;
  float heading;
  float thrust = 0.2;
  float hgtAGL;

  float mass = 10000;
  float fuel = 5000;
  float grossWeight;
  PVector gravity = new PVector(0, 0.016);

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

  void applyForce(PVector force) {
    gravity.mult(grossWeight);
    PVector f = PVector.div(force, grossWeight);
    acc.add(f);
  }

  void turnR(boolean dir) {
    fuel -= 0.5;
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

  void thrusterOn() {
    if (fuel > 0) {
      acc.add(thr);
      fuel -= 5;
      thruster=true;
    }
  }

  void thrusterOff() {
    thruster = false;
  }

  void checkEdges() {

    if (pos.x > width + size) {
      pos.x = -size;
    } else if (pos.x < 0 - size) {
      pos.x = width + size;
    }
    if (hgtAGL == 0) {
      landed = true;
    }
  }

  void update() {
    acc.add(gravity);
    vel.add(acc);
    //vel.limit(40);
    pos.add(vel);
    vel.mult(0.998);
    acc.mult(0);

    grossWeight = mass + fuel;
    hgtAGL = abs(height - pos.y);
    checkEdges();
  }

  void display() {
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
