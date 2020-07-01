//import processing.sound.*;

Lander ldr;
FuelGauge fuelMeter;

Stars[] stars = new Stars[100];

//PImage imgEarth;

void setup() {
  size(1200, 800,P3D);

  //imgEarth = loadImage("erde.png");

  ldr = new Lander(width/2, height/2);
  fuelMeter = new FuelGauge();

  for (int i=0; i < stars.length; i++) {
    stars[i] = new Stars();
  }

}

void draw() {
  // dark blue space
  background(0, 0, 50);

  //basic data
  showData();

  //fuel meter
  fuelMeter.show();

  // draw earth & stars
  showDecorations();

  //update lander acc, vel, pos etc.

  ldr.update();
  ldr.display();
}


void showDecorations() {
  //image(imgEarth, width-width/3, height-height*2/3, 250, 200);
  showStars();
}

void showStars() {
  for (int i=0; i <
    stars.length; i++) {
    stars[i].show();
    stars[i].update();
  }
}

void showData() {
  textSize(16);
  fill(255);
  text("Fuel " + nf(ldr.fuel, 4, 1) + " kg", 10, 20);
  text("Hght " + nf(ldr.hgtAGL, 4, 1) + " m", 10, 40);
  text("vert " + nf(-ldr.vel.y, 2, 2) + " m/s", 10, 60);
  text("horz " + nf(ldr.vel.x, 2, 2) + " m/s", 10, 80);
  text(frameRate, width-50, 20);
  println(ldr.rotation);
}

void keyPressed() {
  if (key == CODED) {
    if(keyCode == UP) {
      ldr.thrusterOn();
    }
    else if (keyCode == LEFT) {
      ldr.turnR(false);
    }
    else if (keyCode == RIGHT) {
      ldr.turnR(true);
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      ldr.thrusterOff();
    }
  }
}

// W I P - midpoint displacement terrain
//
// void terrain(float width, float height, float displace, float roughness) {
//
//   int power;
//   // Gives us a power of 2 based on our width
//   power = round(pow(2, round(log(width) / (log(4)))));
//
//   // Set the initial left point
//   points[0] = height/2 + (random(1)*displace*2) - displace;
//   // set the initial right point
//   points[power] = height/2 + (random(1)*displace*2) - displace;
//   displace *= roughness;
//
//   // Increase the number of segments
//   for (int i = 1; i < power; i *=2) {
// Iterate through each segment calculating the center point
//     for (int j = (power/i)/2; j < power; j+= power/i) {
//       points[j] = ((points[j - (power / i) / 2] + points[j + (power / i) / 2]) / 2);
//       points[j] += (random(1)*displace*2) - displace;
//     }
//     // reduce our random range
//     displace *= roughness;
//   }
//   //return points;
// }
