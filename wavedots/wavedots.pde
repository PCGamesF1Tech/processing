Dot[] dots = new Dot[800];

void setup() {
  size(1200,800,P2D);
  colorMode(HSB);
  //blendMode(ADD);
  for (int i=0; i < dots.length; i++) {
    dots[i] = new Dot();
  }
}

void draw(){
  background(51);
  for (int i=0; i<dots.length;i++) {
    dots[i].update();
    dots[i].display();
    dots[i].edge();
  }
}
