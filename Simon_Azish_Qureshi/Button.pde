public class Button {
  private int quadrant;
  private color offColour;
  private color onColour;
  private boolean isClicked;
  public Button(int quadrant, color off, color on) {
    this.quadrant = quadrant;
    this.offColour = off;
    this.onColour = on;
  }
  
  void display() {
    pushMatrix();
    translate(250, 250);
    rotate(-HALF_PI * (quadrant+1));
    translate(-250, -250);
    if (this.isClicked) {
      fill(onColour);
    } else {
      fill(offColour);
    }
    stroke(#000000);
    strokeWeight(5);
    arc(250, 250, 380, 380, 0, HALF_PI);
    fill(#222222);
    arc(250, 250, 180, 180, 0, HALF_PI);
    popMatrix();
  }

  void checkMouse() {
    //println(color(get(mouseX, mouseY)));
    int colourFinder = color(get(mouseX, mouseY));
    if (colourFinder == this.offColour) {
      this.isClicked = true;
      lastColour = this.quadrant;
    }
  }

  void reset() {
    this.isClicked = false;
  }
}
