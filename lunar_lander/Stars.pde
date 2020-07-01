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

  void update() {
    xSpd = -ldr.vel.x/100;
    x += xSpd;
    if (x > width) {
      x = 0;
    } else if (x < 0) {
      x = width;
    }
  }

  void show() {
    stroke(col);
    strokeWeight(1);
    point(x, y);
  }
}