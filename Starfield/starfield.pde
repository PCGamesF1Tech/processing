float speed = 0.5;
int numStars = 2000;
boolean lightspeed = false;
int tCount = 0;
boolean counter = false;

Star[] stars = new Star[numStars];

void initStars(int num) {
  for (int i=0; i < num; i++) {
    stars[i] = new Star();
  }
}

void setup() {
  size(1440, 960, P3D);
  initStars(numStars);
}

void draw() {
  if (!lightspeed) {
    background(0);
  } 
  translate(width/2, height/2);
  for (int i=0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
  if (counter) {
    tCount++;
    if (tCount >= 100) {
      counter = false;
      tCount= 0;
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    jump();
  } else if (keyCode == DOWN) {
    resume();
  }
}

void jump() {
  lightspeed = true;
  stars = (Star[]) expand(stars, 20000);
  initStars(stars.length);
  speed = 0.2;
  counter = true;
}
void resume() {
  lightspeed = false;
  initStars(numStars);
  speed = 0.5;
  counter = false;
}
