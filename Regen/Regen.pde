
void setup() {
  size(800,600);
  background(50,0,150);
}

void draw() {
 //
 for (int i=0; i < 200; i++) {
   d=new drop;
 strokeWeight(random(20));
 stroke(random(255), random(255), random(255));
 line(random(width), random(height),random(width), random(height));
}
}