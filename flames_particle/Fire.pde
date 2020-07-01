class Fire {

  PVector pos;
  PVector vel;
  float temp = 255;

  Fire(float x_, float y_, float hu) {
    pos=new PVector(x_, y_);
    vel=new PVector(random(-0.7, 0.7),-temp/80);
    hue=hu;
  }

  void update() {
    pos.add(vel);
    temp = temp-5;
    hue = map(temp,0,255,0,65);
  }

  boolean isCold() {
    if (temp <= 0) {
      return true;
    } else {
      return false;
    }
  }

  void show() {
    tint(hue, 100, 100,temp);
    image(img, pos.x, pos.y);
  }
}