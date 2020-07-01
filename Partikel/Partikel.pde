//ParticleSystem ps;
ArrayList<ParticleSystem> systems;

void setup() {
  size(640,500);
  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(255);
  for (ParticleSystem ps: systems) {
    ps.run();
    ps.addParticle();
  }
}
  
void mousePressed() {
  systems.add(new ParticleSystem(1, new PVector(mouseX,mouseY)));
}