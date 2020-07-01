import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class water_new extends PApplet {

float[][] ndata;
float[][] odata;
final float eps = 2;
final float z = 0.2f;
PVector light;
PImage image;
boolean rain;

public void setup()
{
  image = loadImage("wasser.jpg");
  
  ndata = new float[width][height];
  odata = new float[width][height];
  light = new PVector(1, 1, 0);
  light.normalize();
  rain = false;
}

public void draw()
{
 if(mousePressed)
  for(int x = -5; x < 5; x++)
    for(int y = -5; y < 5; y++)
      odata[mouseX + x][mouseY + y] = 0.1f;

  if(random(1) < 0.1f && rain)
  ripple();

  sim();

  //render the ripples
  loadPixels();

  for(int i = 0; i < pixels.length; i++)
  {
    int x = i % width;
    int y = i / width;
    PVector n = new PVector(getVal(x - eps, y) - getVal(x + eps, y), getVal(x, y - eps) - getVal(x, y + eps), eps * 2);
    n.normalize();
    float spec = (1 - (light.x + n.x)) + (1 - (light.y + n.y));
    spec /= 2;
    if(spec > z)
      spec = (spec - z) / (1 - z);
    else
      spec = 0;


    spec *= 255;

    int c = getC(x + n.x * 60, y + n.y * 60);
    float r = red(c) + spec;
    float g = green(c) + spec;
    float b = blue(c) + spec;

    pixels[i] = color(r, g, b);
  }

  updatePixels();
}

public void ripple()
{
  int rx = (int)random(width - 10) + 5;
  int ry = (int)random(height - 10) + 5;
  for(int x = -5; x < 5; x++)
    for(int y = -5; y < 5; y++)
      odata[rx + x][ry + y] = 8;
}

public int getC(float x, float y)
{
  return image.get((int)x, (int)y);
}

public float getVal(float x, float y)
{
  if(x < 1 || y < 1 || x >= width - 1 || y >= height - 1)
    return 0;
  float a = odata[(int)x][(int)y];
  return a;
}

public void sim()
{
  float[][] i = odata;
  odata = ndata;
  ndata = i;

  for(int x = 1; x < width - 1; x++)
    for(int y = 1; y < height - 1; y++)
    {
      float val = (odata[x - 1][y] +
                    odata[x + 1][y] +
                    odata[x][y - 1] +
                    odata[x][y + 1]) / 2;
      val -= ndata[x][y];
      val *=  0.96875f;
      ndata[x][y] = val;
    }
}

public void keyPressed()
{
  rain = !rain;
}
  public void settings() {  size(640, 360); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "water_new" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
