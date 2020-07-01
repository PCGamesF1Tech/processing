class Dot {

  PVector pos;
  PVector vel;
  PVector acc;
  float r;
  float col;
  float xoff=0.1;
  float alpha=255;

  Dot() {
    pos = new PVector(random(width/10), random(height));
    r = random(20,80);
    vel = new PVector(random(0.5,4), random(-1,1));

    col=random(255);
  }

  void update() {
    pos.y += sin(pos.x/r*0.15);
    pos.add(vel);
  }

  void display() {
    noStroke();
    fill(col, 255, 255, 200);
    ellipse(pos.x, pos.y, r, r);
  }

  void edge() {
    if (pos.x > width+r || pos.y < -r || pos.y > height + r) {
      r = random(20, 80);
      pos.x = -r;
      pos.y = random(height);
      vel = new PVector(random(0.5,4), random(-0.3, 0.3));
      col = random(255);
    }
  }
}