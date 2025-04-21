/*Azish Qureshi

 Space Invaders

 A re-creation of Space Invaders.

 December 30, 2022*/

//Loads images into game
PImage shooter;
PImage invaderClose;
PImage invaderOpen;

//Controls the direction of the shooter
boolean left = false;
boolean right = false;

//Decides when the mouse was clickInput
boolean clickInput = false;

//Checks if any invaders are still present
boolean anyLeft = true;

//Decides if the player has won or lost
boolean win = false;
boolean lose = false;

//Tracks the movement of the invaders
boolean glideRight = true;

//Determines if laser is shot
boolean shotLaser = false;

//Decides if the shooter can attack
boolean laserCheck = true;

boolean verify = false;

//Controls the launch button for the laser
boolean spaceKey = false;

//Decides when the game has ended
boolean end = false;

//Variables that allow the timer to function
int timer = 0;
int timerLoop = 0;

//The X position for the shooter
int shooterXpos = 700;

//The speed of the shooter
int shooterFrames = 10;

//Animates the invaders
int animation = 0;

//Decides which screen is shown
int state = 0;

//The X and y positon and the speed for the laser
int laserSpeed = 4;
int laserXPos = 0;
int laserYPos = 0;

int lengthOfArray = 14;

//The maximum Y value of the invaders
int maxY = 0;

//The maximum and minimum values for the arrays
int min = 1400;
int max = 0;

//Finds which invader has to be eliminated
int xDeath;
int yDeath;

//Ensures that the laser only hits a single invader
int laserHealth = 1;

//The amount of points
int points = 0;

//Stores the points the player has gained
int storage;

//The X and y positions of the invaders
int invadersX[][] = {
    new int[lengthOfArray], new int[lengthOfArray], new int[lengthOfArray]};
int invadersY[][] = {
    new int[lengthOfArray], new int[lengthOfArray], new int[lengthOfArray]};

//An array that checks if invaders are alive
boolean alive[][] = {new boolean[lengthOfArray], new boolean[lengthOfArray],
    new boolean[lengthOfArray]};

void setup() {
  size(1400, 900);
  background(#000000);

  //Inserts images
  shooter = loadImage("Shooter.png");
  invaderClose = loadImage("Invader close.png");
  invaderOpen = loadImage("Invader open.png");
  shooter.resize(80, 95);
  invaderClose.resize(60, 60);
  invaderOpen.resize(60, 60);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      invadersX[i][j] = 130 + (80 * j);
    }
  }
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      invadersY[i][j] = 100 * (i + 1);
    }
  }
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      alive[i][j] = true;
    }
  }
}

//Creates and runs the main menu
void mainMenu() {
  strokeWeight(5);
  background(#000000);
  image(shooter, 620, 160);
  fill(#000000);
  noStroke();
  textSize(100);
  fill(#FFFFFF);
  text("Space", 370, 230);
  fill(#FF0000);
  text("Invaders", 700, 230);
  textSize(40);
  fill(#FFFFFF);
  text("By: Azish Qureshi", 560, 290);
  textSize(60);
  stroke(#FFFFFF);
  fill(#000000);
  stroke(#FFFFFF);
  rect(540, 550, 335, 230, 30);
  fill(#FFFFFF);
  textSize(50);
  text("Instructions:", 580, 600);
  textSize(20);
  text("- Use the ← arrow key to move left, ", 550, 630);
  text("and the → arrow key to move right ", 560, 650);
  text("- Use the space key to shoot lasers", 550, 690);
  text("- Use these lasers to eliminate the", 550, 730);
  text("invaders", 560, 750);
  if (mouseX > 580 && mouseX < 830 && mouseY > 400 && mouseY < 500) {
    textSize(50);
    fill(#FFFFFF);
    rect(580, 400, 250, 80, 30);
    fill(#000000);
    text("Start", 650, 455);
  } 
  else {
    textSize(50);
    fill(#000000);
    rect(580, 400, 250, 80, 30);
    fill(#FFFFFF);
    text("Start", 650, 455);
  }
  if (clickInput == true && mouseX > 580 && mouseX < 830 && mouseY > 400
      && mouseY < 500 && verify == false) {
    reset();
    state = 1;
    points = 0;
  }
}

void draw() {
  if (state == 0) {
    mainMenu();
  }

  if (state == 1) {
    allMethods();
  }
}

//Draws the shooter
void createShooter() {
  image(shooter, shooterXpos, 700);
}

//Runs everything related to the laser
void shootLaser() {
  if (spaceKey == true && laserCheck == true) {
    laserXPos = shooterXpos + 80 / 2 - 5;
    shotLaser = true;
    laserHealth = 1;
    laserYPos = height - 150;
    laserCheck = false;
  }
}

void move() {
  if (right == true && shooterXpos < 1400 - 80) {
    shooterXpos = shooterXpos + shooterFrames;
  }
  if (left == true && shooterXpos > 0) {
    shooterXpos = shooterXpos - shooterFrames;
  }
}

//Draws the laser
void createLaser() {
  if (shotLaser == true) {
    noStroke();
    fill(#FFFFFF);
    rect(laserXPos, laserYPos, 5, 20, 80);
  }
}

//Moves the laser
void moveLaser() {
  if (shotLaser == true) {
    laserYPos = laserYPos - 15;
  }

  if (laserYPos < 90) {
    shotLaser = false;
    laserCheck = true;
  }
}

//Draws the invaders
void createInvaders() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      if (animation == 0) {
        if (alive[i][j] == true) {
          image(invaderClose, invadersX[i][j], invadersY[i][j]);
        }
      } 
      else if (animation == 1) {
        if (alive[i][j] == true) {
          image(invaderOpen, invadersX[i][j], invadersY[i][j]);
        }
      }
    }
  }

  timer = millis();
  if (timer - timerLoop > 500) {
    timerLoop = timer;

    //Reverses the animation direction for the invaders
    if (animation == 0) {
      animation = 1;
    } 
    else {
      animation = 0;
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < lengthOfArray; j++) {
        if (glideRight == true) {
          invadersX[i][j] = invadersX[i][j] + 20;
        } 
        else {
          invadersX[i][j] = invadersX[i][j] - 20;
        }
      }
    }
  }
}

//Creates the points
void drawpoints() {
  fill(#FFFFFF);
  textSize(60);
  text("Points :", 580, 50);
  text(points, 775, 50);
}

//Allows the invaders to not fly off the screen. Essentially keeps them in
//place
void barrier() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      if (invadersX[i][j] > max && alive[i][j] == true) {
        max = invadersX[i][j];
      }

      if (invadersX[i][j] < min && alive[i][j] == true) {
        min = invadersX[i][j];
      }
    }
  }

  if (glideRight == true && max > 1310) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < lengthOfArray; j++) {
        invadersY[i][j] = invadersY[i][j] + 40;
      }
    }
    glideRight = false;
    min = 1500;
    max = 0;
  }

  else if (glideRight == false && min < 50) {
    if (points != 0) {
      points = points - 1;
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < lengthOfArray; j++) {
        invadersY[i][j] = invadersY[i][j] + 40;
      }
    }

    //Resets max and min
    min = 1400;
    max = 0;

    //Moves invaders to the right
    glideRight = true;
  }
}

void checker() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      if (invadersY[i][j] > maxY && alive[i][i] == true) {
        maxY = invadersY[i][j];
      }
    }
  }

  /*Checks if the invaders have reached the bottom of the screen.
  This causes the game to end and the player to lose*/
  if (maxY > 650) {
    end = true;
    lose = true;
  } else {
    maxY = 0;
  }

  //Constantly loops to check if the invaders are alive
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      if (alive[i][j] == true) {
        anyLeft = true;
      }
    }
  }

  /*Checks if all the invaders have died. This allows the game to end.
  and the player to win*/
  if (anyLeft == false) {
    end = true;
    win = true;
  } 
  else if (anyLeft == true) {
    anyLeft = false;
  }
}

//Checks if the laser has hit an invader
void invaderLaserHit(int Xvalue, int Yvalue) {
  if (abs(laserXPos - invadersX[Xvalue][Yvalue]) < 40
      && abs(laserYPos - invadersY[Xvalue][Yvalue]) < 50) {
    if (alive[Xvalue][Yvalue] == true && laserHealth == 1) {
      laserHealth = 0;
      shotLaser = false;
      laserCheck = true;
      alive[Xvalue][Yvalue] = false;
      points = points + 1;
    }
  }
}

//Resets all the variables in the game
void reset() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      alive[i][j] = true;
    }
  }

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      invadersX[i][j] = 130 + (80 * j);
    }
  }

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < lengthOfArray; j++) {
      invadersY[i][j] = 100 * (i + 1);
    }
  }
  right = false;
  left = false;
  win = false;
  lose = false;
  end = false;
  glideRight = true;
  timerLoop = timer;
  maxY = 0;
  max = 0;
  min = 1400;
  shooterXpos = width / 2;
  laserXPos = -50;
}

//Stores all the methods needed to run the game
void allMethods() {
  background(#000000);
  createShooter();
  move();
  drawpoints();
  if (end == false) {
    createInvaders();
    barrier();
    shootLaser();
    createLaser();
    moveLaser();
    checker();

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < lengthOfArray; j++) {
        invaderLaserHit(i, j);
      }
    }
  } 
  else if (end == true) {
    if (win == true) {
      background(#000000);
      textSize(80);
      text("Nice!", 610, 280);
      if (mouseX > 480 && mouseX < 680 && mouseY > 420 && mouseY < 500) {
        textSize(40);
        stroke(#FFFFFF);
        fill(#FFFFFF);
        rect(400, 420, 265, 80, 30);
        fill(#000000);
        text("Continue", 450, 470);
      } 
      else {
        textSize(40);
        stroke(#FFFFFF);
        fill(#000000);
        rect(400, 420, 265, 80, 30);
        fill(#FFFFFF);
        text("Continue", 450, 470);
      }
    }

    //Checks if the player lost the game
    if (lose == true) {
      background(#000000);
      stroke(#FFFFFF);
      textSize(80);
      text("You Lose...", 550, 280);
      if (mouseX > 480 && mouseX < 680 && mouseY > 420 && mouseY < 500) {
        textSize(40);
        stroke(#FFFFFF);
        fill(#FFFFFF);
        rect(450, 420, 200, 80, 30);
        fill(#000000);
        text("Restart", 490, 470);
      } 
      else {
        textSize(40);
        fill(#000000);
        rect(450, 420, 200, 80, 30);
        fill(#FFFFFF);
        text("Restart", 490, 470);
      }
    }
    if (mouseX > 720 && mouseX < 920 && mouseY > 420 && mouseY < 500) {
      fill(#FFFFFF);
      rect(710, 420, 275, 80, 30);
      fill(#000000);
      text("Back to menu", 740, 470);
    } 
    else {
      fill(#000000);
      rect(710, 420, 275, 80, 30);
      fill(#FFFFFF);
      text("Back to menu", 740, 470);
    }
    if (clickInput == true && mouseX > 480 && mouseX < 680 && mouseY > 420
        && mouseY < 500 && lose == false) {
      reset();
    } 
    else if (clickInput == true && mouseX > 480 && mouseX < 680
        && mouseY > 420 && mouseY < 500 && lose == true) {
      reset();
      points = 0;
    }
    if (clickInput == true && mouseX > 720 && mouseX < 920 && mouseY > 420
        && mouseY < 500) {
      state = 0;
      reset();
      verify = true;
    }
  }
}

//Read the keys that were pressed
void keyPressed() {
  if (keyCode == 39) {
    right = true;
  }
  if (keyCode == 37) {
    left = true;
  }
  if (keyCode == 32) {
    spaceKey = true;
  }
}

//Reads the keys released
void keyReleased() {
  if (keyCode == 39) {
    right = false;
  }
  if (keyCode == 37) {
    left = false;
  }
  if (keyCode == 32) {
    spaceKey = false;
  }
}

//Checks if the mouse was clickInput
void mousePressed() {
  clickInput = true;
}

//Checks if the mouse was released
void mouseReleased() {
  verify = false;
  clickInput = false;
}
