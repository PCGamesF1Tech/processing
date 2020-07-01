Blob[] blobs = new Blob[15];

void setup() {
  size(800, 600,P2D);
  colorMode(HSB);
  for (int i=0; i < blobs.length; i++) {
    blobs[i] = new Blob(random(width), random(height));
  }
}

void draw() {

  loadPixels();
  for (int x=0; x < width; x++) {
    for (int y=0; y < height; y++) {
      int index = x+y*width;
      float sum = 0;
      for (Blob b : blobs) {
        float d = dist(x, y, b.pos.x, b.pos.y);
        sum += 150 * b.r / d;
      }
      pixels[index]=color(sum,255,255);
    }
  }

  updatePixels();

  for (Blob b : blobs) {
    b.update();
    //b.show();
  }
}