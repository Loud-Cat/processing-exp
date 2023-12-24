// Particle Generator
// Generates new particles every frame
// from a given position on the screen

class Generator {
  // Number of new particles per frame
  int GEN_COUNT = 4;
  
  // Life time (in frames) of the generator
  int MAX_LIFE = 15;
  
  // The position where all particles are generated
  PVector center;
  
  int lifetime;
  ArrayList<Particle> particles;
  
  Generator(PVector center) {
    this.center = center.copy();
    
    lifetime = MAX_LIFE;
    particles = new ArrayList<>();
  }
  
  void update() {
    if (lifetime > 0)
      for (int i = 0; i < GEN_COUNT; i++)
        particles.add( new Particle(center) );
  }
  
  void display() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle particle = particles.get(i);
      
      particle.display();
      particle.update();
      
      if (particle.lifetime <= 0)
        particles.remove(i);
    }
    
    lifetime -= 1;
  }
  
  boolean isDead() {
    return lifetime <= 0 && particles.isEmpty();
  }
}
