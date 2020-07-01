int col=0;

void setup() {
  size(640,360);
  colorMode(HSB);
}

void draw() {
  stroke(col,255,255);
  strokeWeight(random(5,30));
  fill(col,255,255);
  line(pmouseX, pmouseY, mouseX, mouseY);
  col=col + 1;
  if (col>255) {
    col=0;
  }
}
