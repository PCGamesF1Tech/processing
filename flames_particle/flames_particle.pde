ArrayList<Fire> flames;
PImage img;
float hue = 120;

void setup() {
  size(600, 600, P2D);
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 255);
  flames=new ArrayList<Fire>();
  img = loadImage("spark.png");
  noCursor();
}

void draw() {
  background(51);
  flames.add(new Fire(mouseX, mouseY, hue));
  println(flames.size());
  for (Fire f : flames) {
    f.update();
    f.show();
    if (f.isCold()) {
      //flames.remove(flames.size());
    }
  }
}