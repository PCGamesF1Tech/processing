void setup() {
  size(600,400);
  background(0);
  frameRate(100);
}


void draw() {
  //background(0); 
    fill(random(255),random(255),random(255),125);
    ellipse(random(width),random(height),40,40);
}