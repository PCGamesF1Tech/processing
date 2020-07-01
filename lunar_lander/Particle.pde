//for particle effects like thruster, explosion when crashing etc.
class Particle {

  PVector ppos;
  PVector pvel;
  float lifetime;

  Particle(float x_, float y_) {
    ppos = new PVector(x_,y_);
    pvel = new PVector(random(-0.5, 0.5), random(1, 3));
    lifetime = 255;
  }

  void update() {
    ppos.add(pvel);
    lifetime -= 10;
  }

  boolean isDead() {
    if (lifetime <= 0) {
      return true;
    } else {
      return false;
    }
  }

  void show() {
    fill(200, 200, lifetime);
    ellipse(ppos.x, ppos.y, 5,5);
  }
}