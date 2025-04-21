/*Azish Qureshi
 
 Recursion Art
 
 A program that uses
 ellipses, rects, and 
 recursion to make a 
 spiral.
 
 December 8, 2023*/

void setup() {
  size(900,800);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  float hue = map(mouseX, 0, width, 0, 360);
  fill(hue, 100, 100);
  shapes(50, 100); 
}

void shapes(int amount, float i) {
    if(amount > 0) {
      rect(mouseX,mouseY,10*-i,10*-i);
      ellipse(mouseX,mouseY,10*i,10*i);
      ellipse(mouseX,mouseY,10*i,10*i);
      ellipse(mouseX,mouseY,20*i,20*i);
      ellipse(mouseX,mouseY,20*i,20*i);
      translate(230, -150);
      rotate(100+1);
      shapes(amount - 1, i*0.9);
  }
}
