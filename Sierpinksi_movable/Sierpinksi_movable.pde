int N = 3; // Number of control points
int MAX_DIST = 60;
int MANY_TIMES = 2000;
float DIV = 2.0; // You can change the rules for drawing the pattern
 
// Control points
float[] px = new float[N];
float[] py = new float[N];
 
// The moving point, draws the pattern
float selx = 0;
float sely = 0;
 
boolean held = false;
int nearest = -1;
 
void setup()
{
  size(800,600,P2D);
 
  // Initial points, anywhere you like
  px[0] = width/4;
  py[0] = height/4;
  px[1] = width - (width/4);
  py[1] = height/4;
  px[2] = width - (width/4);
  py[2] = height - (height/4);
 
  noFill();
  frameRate(60);
  background(0);
}
 
void mouseMoved()
{
  float neardist = width + height;
  for (int i=0; i<N; i++)
  {
    float nd = dist(px[i],py[i], mouseX,mouseY);
    if (nd < neardist)
    {
      nearest = i;
      neardist = nd;
    }
  }
  if (MAX_DIST < neardist)
  {
    nearest = -1;
  }
}
 
void mousePressed()
{
  if (-1 != nearest)
  {
    held = true;
  }
}
void mouseReleased()
{
  held = false;
}
 
void draw()
{
  // This section allows you to move the control points
  if (held)
  {
    px[nearest] = constrain(mouseX,0,width);
    py[nearest] = constrain(mouseY,0,height);
    background(0);
  }
  // Still not to the pattern code
 
  // Show control points
  for (int i=0; i<N; i++)
  {
    if (i == nearest)
    {
      stroke(0,255,0);
    }
    else
    {
      stroke(0,0,255);
    }
    ellipse( px[i],py[i], MAX_DIST,MAX_DIST );
  }
 
  stroke(255);
  for (int i=0; i<MANY_TIMES; i++) // Draw many points
  {
    // These are the lines that actually generate the pattern.
    int thistime = (int)random(N);
    float nx = ((px[thistime] - selx) / DIV) + selx;
    float ny = ((py[thistime] - sely) / DIV) + sely;
    selx = nx;
    sely = ny;
    // Yep, that is it.
 
    point( nx, ny );
  }
}