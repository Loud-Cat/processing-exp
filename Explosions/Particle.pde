// Particle
// This class represents a single particle of an explosion

color RED = color(255, 0, 0);
color YEL = color(255, 255, 0);

class Particle {
  int MAX_LIFE = 25; // Lifetime (in frames) of each particle
  int MAX_RAD = 8;   // Starting radius of each particle
  
  PVector pos, vel;
  int lifetime;
  int radius;
  
  Particle(PVector pos) {
    this.pos = pos.copy();
    this.vel = PVector.random2D().mult(5);
    
    lifetime = MAX_LIFE;
    radius = MAX_RAD;
  }
  
  void update() {
    pos.add(vel);
    
    // Reduce lifetime each frame
    lifetime -= 1;
    
    // Radius reaches 0 at the same rate that lifetime does
    radius = (lifetime * MAX_RAD) / MAX_LIFE;
  }
  
  void display() {
    // Interpolate between red and yellow
    // Depending on the lifetime of the particle.
    // (start at RED, end at YELLOW)
    float t = float(MAX_LIFE - lifetime) / MAX_LIFE;
    fill( lerpColor(RED, YEL, t) );
    
    circle(pos.x, pos.y, radius * 2);
  }
}
