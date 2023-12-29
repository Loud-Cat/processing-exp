
/** A simple text box utility for getting text input in a sketch.
  * To use: call textbox.display() during draw() and mouse/key listeners
  * during mouseClicked() and keyPressed()
  */
class TextBox {
  PVector pos;
  String content;
  boolean active;
  
  TextBox(float x, float y) {
    pos = new PVector(x, y);
    
    content = "";
    active = false;
  }
  
  void display() {
    fill(255);
    strokeWeight(5);
    
    if (active)
      stroke(255, 255, 0);
    else
      stroke(150);
    
    rect(pos.x, pos.y, 400, 60);
    
    fill(0);
    noStroke();
    textSize(50);
    textAlign(LEFT, BOTTOM);
    text(content, pos.x + 5, pos.y + 60);
  }
  
  /** Determine if the user has clicked inside the text box */
   void listenMouse() {
     boolean x = (mouseX > pos.x && mouseX < pos.x + 400);
     boolean y = (mouseY > pos.y && mouseY < pos.y + 60);
     active = (x && y);
  }
  
  /** Add/remove user's text to/from the textbox */
  void listenKey() {
    if (!active)
      return;
    
    if (keyCode == BACKSPACE) {
      if ( !content.isEmpty() )
        content = content.substring(0, content.length() - 1);
    }
    else if (content.length() < 3 && isValidKey())
      content += Character.toUpperCase(key);
  }
}
