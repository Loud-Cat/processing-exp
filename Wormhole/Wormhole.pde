int FRAMES = 250;

void setup() {
  size(500, 500, P3D);
  ellipseMode(RADIUS);
}

void draw() {
  background(50);
  translate(width/2, height/2, 0);
  
  stroke(50, 200, 50);
  strokeWeight(2);
  fill(0);
  
  float t = map(frameCount, 0, FRAMES, 0, TWO_PI);
  rotateX(sin(t) * QUARTER_PI);
  rotateZ(t);
  
  int step = 8;
  int h = 250;
  
  for (int r = 0; r < width; r += step) {
    float nr1 = float(r) / width;
    float z1 = h * getZ(nr1);
    
    float r2 = r + step;
    float nr2 = r2 / width;
    float z2 = h * getZ(nr2);
    
    beginShape(TRIANGLE_STRIP);
    for (int a = 0; a <= 360; a += 15) {
      float rdn1 = radians(a);
      float rdn2 = radians(a + 15);
      
      float x1 = r * cos(rdn1);
      float y1 = r * sin(rdn1);
      vertex(x1, y1, z1);
      
      float x2 = r2 * cos(rdn2);
      float y2 = r2 * sin(rdn2);
      vertex(x2, y2, z2);
    }
    endShape(CLOSE);
  }
}

/** Returns the z-coordinate of a given position on the curve */
float getZ(float x) {
  return 1 - (0.1 / x);
}
