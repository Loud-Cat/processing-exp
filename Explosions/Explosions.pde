// Explosions
// Every few frames, an explosion will appear.
// You can also click the screen to create an explosion.

ArrayList<Generator> generators;

// Delay (in frames) between new explosions
int EXP_DELAY = 50;

void setup() {
  size(600, 600);
  ellipseMode(RADIUS);
  noStroke();
  
  generators = new ArrayList<>();
}

void draw() {
  background(200);
  
  // Draw all particles to the screen
  // and remove "dead" generators
  for (int i = generators.size() - 1; i >= 0; i--) {
    Generator generator = generators.get(i);
    
    generator.display();
    generator.update();
    
    if ( generator.isDead() )
      generators.remove(i);
  }
  
  // Every few frames, add a new particle generator
  if (frameCount % EXP_DELAY == 0) {
    PVector center = new PVector(random(100, width - 100), random(100, height - 100));
    Generator gen = new Generator(center);
    generators.add(gen);
  }
  
  if (frameCount < EXP_DELAY * 6)
    saveFrame("out/frame-####.png");
  else
    exit();
}

void mouseClicked() {
  PVector mouse = new PVector(mouseX, mouseY);
  generators.add( new Generator(mouse) );
}
