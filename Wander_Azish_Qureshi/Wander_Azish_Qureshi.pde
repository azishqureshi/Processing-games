/*Azish Qureshi

 Wander

 A custom physics game
 by Azish Qureshi.

 January 24, 2022*/

//Declares images
PImage Crosshair;
PImage Car;
PImage Star;
PImage Lock;

//Pvectors for gravity
PVector pos, vel, acc;
PVector pos4, vel4, acc4;
PVector pos2 = new PVector(0, 0);
PVector vel2 = new PVector(0, 0);
PVector acc2 = new PVector(0, 1);
PVector pos3 = new PVector(0, 0);
PVector vel3 = new PVector(0, 0);
PVector acc3 = new PVector(0, 1);

//Determines whether the game has ended or not
boolean start = false;
boolean end = false;

//Determines which way the protagonist should move
boolean moveRight = false;
boolean moveLeft = false;
boolean moveRight2 = false;
boolean moveLeft2 = false;

//X and y positions for the protagonist
int protagonistX = 70;
int protagonistY = 630;
int protagonistX2 = 70;
int protagonistY2 = 630;

//X and y values of the obstacles
int boxObstacleX = 280;
int boxObstacleY = 580;
int balloonObstacleX = 500;
int balloonObstacleY = 300;
int stringObstacleX = 500;
int stringObstacleY = 400;
int stringObstacleX2 = 500;
int stringObstacleY2 = 400;
int secondStringYpos = 100;

//Determines when the timer begins running
boolean timer = false;

//Determines the state of the game
int gameState = 1;

//X and Y positions of the stars for level 1
float starsY = 100;
int starsX = 100;

//The total time that is being subtracted in the timer
int totalTime = 40000;

//Determines if the player cut the string
boolean cutString = false;
boolean cutString2 = false;

//Decides which level has been finished
boolean level1Complete = false;

//Decides if barrier or car on level 1 is gone
boolean barrierGone = false;
boolean carGone = false;

//Decides if barrier or car on level 2 is gone
boolean barrierGone2 = false;

//Determines if the game is paused or not
boolean pauseit = false;

//Float variables for gravity
float xPos;
float yPos;
float speed;
float gravity;

void setup() {
  size(1050, 700);
  Crosshair = loadImage("Sword Cursor.png");
  Car = loadImage("Car.png");
  Star = loadImage("Star.png");
  Lock = loadImage("Lock.png");
  Crosshair.resize(40, 40);
  Car.resize(140, 90);
  Star.resize(45, 40);
  Lock.resize(40, 40);
  pos = new PVector(0, 4.6);
  vel = new PVector(0, 3.6);
  acc = new PVector(0, 4.6);
  pos4 = new PVector(0, 4.6);
  vel4 = new PVector(0, 3.6);
  acc4 = new PVector(0, 4.6);
}

void draw() {
  background(0);
  if (start == false) {
    startScreen();
    totalTime = 40000;
    protagonistX = 70;
    protagonistY = 630;
  } 
  else if (start == true) {
    levelSelection();
    level1();
    level2();
    protagonist();
    Obstacles();
    reset();
    Interface();
    timer();
    endScreen();
  }
}

//Sets the start screen for the game. Includes the start button
void startScreen() {
  background(#87CEEB);
  textSize(170);
  stroke(5);
  text("Wander", 260, 170);
  textSize(40);
  text("By: Azish Qureshi", 390, 215);
  text("How to play:", 430, 490);
  textSize(25);
  text("- Use the arrow keys to move right and left", 290, 560);
  text("- Use the mouse to manipulate the environment", 290, 590);
  text("(e.g. break obstacles)", 300, 620);
  text("- Use the space bar to jump", 290, 650);
  text("- Reach the end of the map before the timer runs out!", 290, 680);
  fill(#FFFFFF);
  textSize(40);
  if (mouseX > 365 && mouseX < 691 && mouseY > 310 && mouseY < 382
      && mousePressed == true) {
    start = true;
  }
  if (mouseX > 365 && mouseX < 691 && mouseY > 310 && mouseY < 382) {
    fill(#FFFFFF);
    stroke(#FFFFFF);
    strokeWeight(5);
    rect(365, 310, 330, 70, 20);
    fill(#87CEEB);
    text("Start Game", 440, 360);
    fill(#FFFFFF);
  } 
  else {
    fill(#87CEEB);
    stroke(#FFFFFF);
    strokeWeight(5);
    rect(365, 310, 330, 70, 20);
    fill(#FFFFFF);
    text("Start Game", 440, 360);
  }
}

//Sets the end screen for the game. Includes a restart button
void endScreen() {
  if (end == true) {
    background(#87CEEB);
    textSize(40);
    if (mouseX > 365 && mouseX < 691 && mouseY > 450 && mouseY < 522
        && mousePressed == true) {
      start = false;
      end = false;
      gameState = 1;
    }
    if (mouseX > 365 && mouseX < 691 && mouseY > 450 && mouseY < 522) {
      fill(#FFFFFF);
      stroke(#FFFFFF);
      strokeWeight(5);
      rect(365, 450, 330, 70, 20);
      fill(#87CEEB);
      text("Restart", 470, 500);
      fill(#FFFFFF);
    } 
    else {
      fill(#87CEEB);
      stroke(#FFFFFF);
      strokeWeight(5);
      rect(365, 450, 330, 70, 20);
      fill(#FFFFFF);
      text("Restart", 470, 500);
    }
    textSize(150);
    text("Game Over", 200, 170);
  }
}

//Resets variable and PVectors when the game ends
void reset() {
  if (end == true || gameState == 1) {
    cutString = false;
    cutString2 = false;
    totalTime = 40000;
    protagonistX = 70;
    protagonistY = 630;
    barrierGone = false;
    barrierGone2 = false;
    carGone = false;
    pos = new PVector(0, 4.6);
    vel = new PVector(0, 3.6);
    acc = new PVector(0, 4.6);
    pos4 = new PVector(0, 4.6);
    vel4 = new PVector(0, 3.6);
    acc4 = new PVector(0, 4.6);
  }
}

/*Creates the protagonist. This includes everything related to the protagonist
 including their appearance, abilities, etc*/
void protagonist() {
  if (gameState == 2) {
    fill(#FFFFFF);
    ellipse(protagonistX + pos2.x + width / 20, pos2.y, 60, 60);
    pos2.add(vel2);
    vel2.add(acc2);
  }
  if (pos2.y > height - 70) {
    pos2.y = height - 70;
  }
  if (protagonistX == 970) {
    gameState = 1;
    level1Complete = true;
  }
  if (moveRight == true && 970 > protagonistX) {
    protagonistX = protagonistX + 10;
  }
  if (protagonistX > 110 && carGone == false) {
    protagonistX = protagonistX - 10;
  }
  if (280 < protagonistX && barrierGone == false) {
    protagonistX = protagonistX - 10;
  }
  if (protagonistX > 570 && protagonistX < 660 && pos2.y > 520) {
    protagonistX = 580;
  }
  if (protagonistX > 700 && protagonistX < 890 && pos2.y == 630) {
    protagonistX = 70;
  }
  if (moveLeft == true && -20 < protagonistX) {
    protagonistX = protagonistX - 10;
  }
  if (gameState == 3) {
    fill(#FFFFFF);
    ellipse(protagonistX2 + pos3.x + width / 20, pos3.y, 60, 60);
    pos3.add(vel3);
    vel3.add(acc3);
  }
  if (moveRight2 == true && protagonistX2 < 940) {
    protagonistX2 = protagonistX2 + 5;
  }
  if (moveLeft2 == true && protagonistX2 > 0) {
    protagonistX2 = protagonistX2 - 5;
  }
  if (400 < protagonistX2 && barrierGone2 == false) {
    protagonistX2 = protagonistX2 - 5;
  }
  if (pos3.y > height - 100) {
    pos3.y = height - 100;
  }
}

//Detects when you press a key. Specifically used for the protagonist's movements
void keyPressed() {
  if (keyCode == 39) {
    moveRight = true;
  }
  if (keyCode == 37) {
    moveLeft = true;
  }
  if (keyCode == 39) {
    moveRight2 = true;
  }
  if (keyCode == 37) {
    moveLeft2 = true;
  }
  if (keyCode == 32 && 600 < pos2.y) {
    vel2.set(0, -15);
  }
  if (keyCode == 32 && 570 < pos3.y) {
    vel3.set(0, -15);
  }
}

//Detects when you release a key. Specifically used for the protagonist's
//movements
void keyReleased() {
  if (keyCode == 39) {
    moveRight = false;
  }
  if (keyCode == 37) {
    moveLeft = false;
  }
  if (keyCode == 39) {
    moveRight2 = false;
  }
  if (keyCode == 37) {
    moveLeft2 = false;
  }
}

//Detects mouse presses. Is exclusively used for the pause button
void mousePressed() {
  if (mouseX > 6 && mouseX < 51 && mouseY < 36 && mouseY > 5
      && mousePressed == true)
    pauseit = !pauseit;
  if (pauseit) {
    textSize(100);
    strokeWeight(5);
    stroke(#FFFFFF);
    fill(#87CEEB);
    rect(320, 280, 380, 90, 20);
    fill(#FFFFFF);
    text("Paused", 360, 358);
    textSize(60);
    noLoop();
  } 
  else {
    loop();
  }
}

//Creates the box obstacles for the game.
void Obstacles() {
  if (gameState == 2) {
    stroke(#000000);
    strokeWeight(3);
    line(stringObstacleX, stringObstacleY - 100, stringObstacleX, stringObstacleY - 100 + 50);
    line(stringObstacleX + pos.x, stringObstacleY + pos.y - 80, stringObstacleX + pos.x, stringObstacleY + pos.y - 10);
    strokeWeight(1);
    fill(#FF0000);
    rect(480, 630, 40, 30);
    fill(#928E85);
    if (barrierGone == false) {
      rect(360, -5, 30, 705);
    }
    rect(660, -5, 30, 460);
    rect(660, 540, 30, 500);
    rect(461, 650, 80, 20);
    fill(#5C4033);
    rect(boxObstacleX + pos.x + 181, boxObstacleY + pos.y - 240, 80, 80);
    fill(#FF0000);
    if (carGone == false) {
      image(Car, 180, 480);
      image(Car, 185, 530);
      image(Car, 190, 580);
    }
    if (mouseX > 195 && mouseX < 322 && mouseY > 490 && mouseY < 660) {
      carGone = true;
    }
    ellipse(balloonObstacleX, balloonObstacleY, 30, 40);
    if (cutString == true) {
      vel.add(acc);
      pos.add(vel);
      if (pos.y > (height - 460)) {
        pos.y = height - 460;
        vel.y *= -.9; //Bouncing factor
        if (pos.y == 240.0) {
          barrierGone = true;
        }
      }
      if (pos.x > width)
        fill(#FFFFFF);
    }
  }
  if (mouseX > 490 && mouseX < 520 && mouseY > 322 && mouseY < 380) {
    cutString = true;
  }
  if (gameState == 3) {
    if (mouseX > 481 && mouseX < 507 && mouseY > 488 && mouseY < 651) {
      barrierGone2 = true;
    }
    strokeWeight(5);
    line(stringObstacleX2 + 370, stringObstacleY2 - 330, stringObstacleX2 + 370, stringObstacleY2 - 180);
    line(stringObstacleX2 + pos4.x + 370, stringObstacleY2 + pos4.y - 180, stringObstacleX2 + pos.x + 370, stringObstacleY2 + pos4.y - 103);
    strokeWeight(2);
    if (barrierGone2 == false) {
      rect(480, 494, 30, 130);
    }
  }
  strokeWeight(1);
  if (pos4.y == 240.0) {
    barrierGone = true;
  }
  if (cutString2 == true) {
    vel4.add(acc4);
    pos4.add(vel4);
    if (pos4.y > (height - 425)) {
      pos4.y = height - 425;
      vel4.y *= -.9; //Bouncing factor
    }
  }
  if (mouseX > 865 && mouseX < 875 && mouseY > 73 && mouseY < 300) {
    cutString2 = true;
  }
}

//Creates the menu that you select levels from
void levelSelection() {
  if (gameState == 1) {
    background(#87CEEB);
    for (int i = 0; i < 4; i++) {
      textSize(140);
      stroke(5);
      text("Select Level", 200, 150);
      fill(#87CEEB);
      stroke(#FFFFFF);
      strokeWeight(5);
      rect(285 + i * 150, 380, 80, 70, 20);
      fill(#FFFFFF);
      textSize(60);
      text(i + 1, 310 + i * 150, 435);
    }
    if (mouseX > 287 && mouseX < 362 && mouseY > 382 && mouseY < 449) {
      fill(#FFFFFF);
      stroke(#FFFFFF);
      strokeWeight(5);
      rect(285 + 0 * 150, 380, 80, 70, 20);
      fill(#87CEEB);
      textSize(60);
      text(1, 310 + 0 * 150, 435);
    }
    if (level1Complete == true) {
      image(Star, 340, 365);
    }
    if (mouseX > 287 && mouseX < 362 && mouseY > 382 && mouseY < 449
        && mousePressed == true) {
      timer = true;
      gameState = 2;
    }
    if (mouseX > 437 && mouseX < 512 && mouseY > 382 && mouseY < 449) {
      fill(#FFFFFF);
      stroke(#FFFFFF);
      strokeWeight(5);
      rect(285 + 1 * 150, 380, 80, 70, 20);
      fill(#87CEEB);
      textSize(60);
      text(2, 310 + 1 * 150, 435);
    }
    if (mouseX > 437 && mouseX < 512 && mouseY > 382 && mouseY < 449
        && mousePressed == true) {
      timer = true;
      gameState = 3;
    }
    if (mouseX > 587 && mouseX < 662 && mouseY > 382 && mouseY < 449) {
      fill(#FFFFFF);
      stroke(#FFFFFF);
      strokeWeight(5);
      rect(285 + 2 * 150, 380, 80, 70, 20);
      fill(#87CEEB);
      textSize(60);
      text(3, 310 + 2 * 150, 435);
    }
    if (mouseX > 737 && mouseX < 812 && mouseY > 382 && mouseY < 449) {
      fill(#FFFFFF);
      stroke(#FFFFFF);
      strokeWeight(5);
      rect(285 + 3 * 150, 380, 80, 70, 20);
      fill(#87CEEB);
      textSize(60);
      text(4, 310 + 3 * 150, 435);
    }
    image(Lock, 640, 365);
    image(Lock, 790, 365);
  }
}

//Creates, displays, and runs the timer for the game
void timer() {
  if (gameState == 2 && timer == true || gameState == 3 && timer == true) {
    for (int i = 0; i < 40; i++) {
      totalTime = totalTime - 1;
    }
    if (totalTime == 0) {
      gameState = 0;
      end = true;
      timer = false;
    }
    text(totalTime, 900, 60);
  }
}

//Creates the interface during the game (disculding the timer)
void Interface() {
  if (gameState == 2 || gameState == 3) {
    image(Crosshair, mouseX - 26, mouseY - 28);
    fill(#87CEEB);
    strokeWeight(2);
    stroke(#FFFFFF);
    ellipse(30, 30, 50, 50);
    fill(#FFFFFF);
    triangle(20, 45, 20, 17, 47, 33);
  }
}

//Runs code related to creating level 1
void level1() {
  if (gameState == 2) {
    background(#191970);
    for (int i = 0; i < 50; i++) {
      strokeWeight(1);
      drawMoon(120, 20);
      stroke(#000000);
      drawRoad(50, 650);
      drawBuilding(1 + 75 * i, 600, 100, 320 + sin(i) * 50);
      drawStars(starsX + 20 * i, starsY + sin(i) * 120 + 10);
      fill(#000000);
      rect(1000, 370, 20, 290);
      fill(#FF0000);
      triangle(866, 400, 1001, 370, 1000, 430);
      fill(#FF0000);
      rect(770, 630, 150, 30);
      fill(#928E85);
      rect(751, 650, 190, 20);
    }
  }
}

//Runs code related to creating level 2
void level2() {
  if (gameState == 3) {
    background(#87CEEB);
    Nameplate(20, 70);
    textSize(30);
    if (barrierGone2 == true) {
      text("↓ Exit ↓", 475, 600);
    }
    textSize(60);
    text("Level Not Complete", 270, 60);
    strokeWeight(2);
    stroke(#000000);
    fill(#FFFFFF);
    strokeWeight(1);
  }
}

//Draws a building
void drawBuilding(float xPos, int yPos, float w, float h) {
  fill(#928E85);
  rect(xPos, yPos, w, -h);
  for (int i = 0; i < (w - 8) / 12; i++) {
    for (int j = 0; j < (h) / 15; j++) {
      fill(#FFFF00);
      rect(xPos + 4 + 12 * i, yPos - h / 5 - 12 * j, 10, 10);
    }
  }
}

//Draws stars
void drawStars(int xPos, float yPos) {
  for (int i = 0; i < 1; i++) {
    fill(#FFFFFF);
    rect(xPos, yPos + 5 * i, 5, 5);
  }
}

//Draws road
void drawRoad(int xPos, int yPos) {
  fill(#5A5A5A);
  rect(0, 600, 1100, 200);
  for (int i = 0; i < 10; i++) {
    fill(#FFFFFF);
    rect(xPos + 150 * i, yPos, 80, 10, 5);
  }
}

//Draws moon
void drawMoon(int xPos, int yPos) {
  stroke(#000000);
  fill(#FFFFFF);
  ellipse(xPos, yPos + 100, 200, 200);
}

void Nameplate(int xPos, int yPos) {
  //Let xPos = 100, Let yPos = 100
  //Code below draws computer
  stroke(#000000);
  strokeWeight(10);
  fill(#000000);
  rect(xPos + 400, yPos + 500, 200, 200);
  rect(xPos, yPos, 1000, 600);
  fill(#0000FF);
  rect(xPos, yPos, 1000, 600);
  //Code below draws apps and toolbar
  fill(#FFFFFF);
  strokeWeight(0);
  rect(xPos + 5, yPos + 555, 990, 40);
  fill(#808080);
  rect(xPos + 15, yPos + 563, 250, 25);
  fill(#FF0000);
  rect(xPos + 280, yPos + 563, 25, 25);
  fill(#0000FF);
  rect(xPos + 330, yPos + 563, 25, 25);
  fill(#00FF00);
  rect(xPos + 380, yPos + 563, 25, 25);
  fill(#150000);
  rect(xPos + 430, yPos + 563, 25, 25);
  fill(#FFBD33);
  rect(xPos + 480, yPos + 563, 25, 25);
  fill(#33FFBD);
  rect(xPos + 530, yPos + 563, 25, 25);
  fill(#E6F613);
  rect(xPos + 580, yPos + 563, 25, 25);
  fill(#9008F9);
  rect(xPos + 630, yPos + 563, 25, 25);
  fill(#F9088F);
  rect(xPos + 680, yPos + 563, 25, 25);
  fill(#DA4904);
  rect(xPos + 730, yPos + 563, 25, 25);
  fill(#5A08EC);
  rect(xPos + 780, yPos + 563, 25, 25);
  fill(#5A08EC);
  rect(xPos + 780, yPos + 563, 25, 25);
  fill(#08A1EC);
  rect(xPos + 830, yPos + 563, 25, 25);
  strokeWeight(5);
  line(xPos + 980, yPos + 563, xPos + 880, yPos + 563);
  line(xPos + 960, yPos + 575, xPos + 880, yPos + 575);
  line(xPos + 940, yPos + 586, xPos + 880, yPos + 586);
  //Code below draws name
  DrawA(xPos, yPos - 70);
  DrawZ(xPos, yPos - 70);
  DrawI(xPos, yPos - 70);
  DrawS(xPos, yPos - 70);
  DrawH(xPos, yPos - 70);
}

void DrawA(int xPos, int yPos) {
  //This code draws an A
  //Let xPos = 100, Let yPos = 100
  fill(#FFFFFF);
  strokeWeight(0);
  rect(xPos + 73, yPos + 300, 110, 50);
  triangle(xPos + 20, yPos + 500, xPos + 125, yPos + 100, xPos + 80, yPos + 500);
  triangle(xPos + 180, yPos + 500, xPos + 125, yPos + 100, xPos + 240, yPos + 500);
}

void DrawZ(int xPos, int yPos) {
  //This code draws a Z
  //Let xPos = 100, Let yPos = 100
  stroke(#0000FF);
  fill(#FFFFFF);
  strokeWeight(1);
  rect(xPos + 270, yPos + 100, 150, 30);
  rect(xPos + 270, yPos + 125, 150, 350);
  fill(#0000FF);
  triangle(xPos + 300, yPos + 475, xPos + 420, yPos + 125, xPos + 450, yPos + 475);
  triangle(xPos + 270, yPos + 125, xPos + 270, yPos + 475, xPos + 390, yPos + 125);
  fill(#FFFFFF);
  rect(xPos + 272, yPos + 465, 150, 30);
}

void DrawI(int xPos, int yPos) {
  //This code draws an I
  //Let xPos = 100, Let yPos = 100
  strokeWeight(0);
  fill(#FFFFFF);
  rect(xPos + 460, yPos + 100, 30, 395);
}

void DrawS(int xPos, int yPos) {
  //This code draws an S
  //Let xPos = 100, Let yPos = 100
  fill(#FFFFFF);
  strokeWeight(0);
  ellipse(xPos + 620, yPos + 300, 200, 390);
  fill(#0000FF);
  ellipse(xPos + 680, yPos + 200, 170, 100);
  ellipse(xPos + 575, yPos + 400, 170, 100);
}

void DrawH(int xPos, int yPos) {
  //This code draws an H
  //Let xPos = 100, Let yPos = 100
  fill(#FFFFFF);
  strokeWeight(0);
  strokeWeight(0);
  rect(xPos + 770 + pos4.x, yPos + 300 + pos4.y, 155, 50);
  rect(xPos + 750, yPos + 100, 30, 395);
  rect(xPos + 920, yPos + 100, 30, 395);
}
