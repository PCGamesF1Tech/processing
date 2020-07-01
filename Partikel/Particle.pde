class Particle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
   
  Particle(PVector loc) {
    acceleration = new PVector(0,0.5);
    velocity = new PVector(random(-1,1), random(-2,0));
    location = loc.get();
    lifespan = 500;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2;
  }
   
  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(random(50),random(50),random(50,255), lifespan);
    ellipse(location.x, location.y, 12,12);
  }
  
  boolean isDead(){
    if (lifespan <= 0) {
      return true;
    } else {
      return false;
    }
  }
}