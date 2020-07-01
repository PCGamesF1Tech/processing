class Star {

  float x;
  float y;
  float z;
  float pz;
  int fac = 100;

  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(255);
    pz = z;
  }

  void update() {
    z = z - speed;
    if (z < 1) {
      x = random(-width, width);
      y = random(-height, height);
      z = 255;
      pz = z;
    }
  }

  void show() {
    float sx = fac * x / z;
    float sy = fac * y / z;

    float px = fac * x /pz;
    float py = fac * y / pz;

    pz = z;


    if (!lightspeed) {

      fill(map(z, 255, 0, 0, 255), 128);
      float r = map(z, width, 0, 1, 3);
      strokeWeight(r);
      stroke(map(z, 255, 0, 0, 255));
    } else {
      strokeWeight(2);
      stroke(255, 170);
    }

    line(px, py, sx, sy);
  }
}
