int resolution = 5; //<>//
ArrayList<Block> Tiles;
boolean run = false;
int numTiles = 0;
int columns = 0;
int currColumn = 0;
int rows = 0;
IntList rndCol;
//int(12);


void setup() {
  size(1000, 800);
  Tiles = new ArrayList<Block>();
  rndCol = new IntList();
  columns = width/resolution;
  rows = height/resolution;
  colorMode(HSB, columns, 255, 255);
  numTiles = rows * columns;

  for (int y = 0; y < height; y+=resolution) {

    for (int i = 0; i < columns; i++) {
      rndCol.append(i);
    }

    rndCol.shuffle();
    for (int x = 0; x < width; x+=resolution) {
      Tiles.add(new Block(x, y, resolution, rndCol.get(currColumn)));
      currColumn += 1;
    }
    rndCol.clear();
    currColumn = 0;
  }
  background(0);
  textSize(26);
  text("click to begin...", width/2, height/2);
}

void draw() {
  if (run) {

    for (int i = numTiles-1; i > 0; i--) {
      Block b = Tiles.get(i);
      b.display();
      b.checkPos();
    }
  }
}

void mousePressed() {
  run = !run;
}
