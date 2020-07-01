class Block {

  int xPos;
  int yPos;
  int col;
  int res;

  Block(int x, int y, int bSize, color bCol) {
    xPos = x;
    yPos = y;
    res = bSize;
    col = bCol;
  }

  void checkPos() {
    if (map(xPos,0,width,0,columns) <= col) {
      xPos += 1;
    } else {
      xPos -= 1;
    }
  }

  boolean inPos() {
    if (xPos == col) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    stroke(0,12);
    noStroke();
    fill(col, 255, 255,20);
    square(xPos, yPos, res);
  }
}  
