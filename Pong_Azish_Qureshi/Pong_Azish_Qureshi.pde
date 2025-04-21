/*Azish Qureshi
 
 Pong
 
 A custom Pong game
 
 November 29, 2022*/

//X and y variables for paddles and ball
int ballX = 400;
int ballY = 400;

int xSpeed = 5;
int ySpeed = 5;

int paddle1Xpos = 40;
int paddle1Ypos = 350;

int paddle2Xpos = 730;
int paddle2Ypos = 350;

//The scores for player 1 and 2
int p1Score = 0;
int p2Score = 0;

//Boolean switch for the x and y movements of the paddles
boolean moveUp1 = false;
boolean moveDown1 = false;
boolean moveUp2 = false;
boolean moveDown2 = false;

//Boolean for the start and end screen
boolean start = false;
boolean end = false;

//Specifies window size and enables start screen to
void setup() {
  startScreen();
  size(800, 800);
  textSize(50);
}

//Animates paddles and ball. Also enables start screen to run
void draw() {
  if (start == true) {
    if (p1Score == 5) {
    end = true;
  }
  if (p2Score == 5) {
    end = true;
  }
    background(#000000);
    fill(#FF0000);
    text(p1Score, 100, 40);
    fill(#0000FF);
    text(p2Score, 670, 40);
    fill(#FFFFFF);
    fill(#000000);
    stroke(#FF0000);
    strokeWeight(10);
    paddle1();
    stroke(#0000FF);
    paddle2();
    stroke(#000000);
    fill(#FFFFFF);
    ball();
    ballMotion();
    ballEdgeDetection();
    endScreen();
  }
}


//Start screen
void startScreen() {
  background(#000000);
  textSize(80);
  fill(#FF0000);
  text("Po", 320, 280);
  fill(#0000FF);
  text("ng", 405, 280);
  fill(#FFFFFF);
  textSize(50);
  fill(#000000);
  stroke(#FFFFFF);
  strokeWeight(5);
  rect(240,450,330,70,20);
  stroke(#FFFFFF);
  strokeWeight(5);
  rect(240,550,335,160,20);
  fill(#FFFFFF);
  text("Instructions:", 275, 600);
  fill(#FFFFFF);
  text("Press A to start", 250, 500);
  textSize(20);
  text("- Player 1 (left) uses the ↑ and ↓ keys", 250, 630);
  text("- Player 2 (right) uses the W and S keys", 250, 660);
  text("- First one to make it to 5 points wins!", 250, 690);
  fill(#FFFFFF);
  textSize(30);
  text("By: Azish Qureshi", 300, 320);  
}

//Checks the scores of each player and determines the winner. Also sets the endscreen
void endScreen() {
  if (end == true && p1Score == 5) {
    xSpeed = 0;
    ySpeed = 0;
    background(#000000);
    textSize(50);
    fill(#FF0000);  
    text("Player 1 wins!", 260, 400);
    fill(#000000);
    stroke(#FFFFFF);
    strokeWeight(5);
    rect(230,450,360,70,20);
    fill(#FFFFFF);
    text("Press R to restart", 235, 500);
    if(keyCode == 82){
    end = false;
    p1Score = 0;
    p2Score = 0;
    ballX = 400;
    ballY = 400;
    xSpeed = 5;
    ySpeed = 5;
    }
  }
  if (end == true && p2Score == 5) {
    xSpeed = 0;
    ySpeed = 0;
    background(#000000);
    fill(#0000FF);
    text("Player 2 wins!", 260, 400);
    fill(#000000);
    stroke(#FFFFFF);
    strokeWeight(5);
    rect(230,450,360,70,20);
    fill(#FFFFFF);
    text("Press R to restart", 235, 500);
    if(keyCode == 82){
    end = false;
    p1Score = 0;
    p2Score = 0;
    ballX = 400;
    ballY = 400;
    xSpeed = 5;
    ySpeed = 5;
    }
  }
}


//Draws ball
void ball() {
  ellipseMode(CORNERS);
  ellipse(ballX, ballY, ballX+40, ballY+40);
}

//Allows the ball to move
void ballMotion() {
  ballX = ballX + xSpeed;
  ballY = ballY + ySpeed;
}

/*Detects when the ball hits the edge of the screen/the paddles
 this also allows the game to calculate the scores (add to the pscore variables)*/

void ballEdgeDetection() {

  if (ballY <= paddle1Ypos + 200 && ballX <= paddle1Xpos + 40 && ballY >= paddle1Ypos) {
    xSpeed = -xSpeed;
  }

  if (ballY <= paddle2Ypos + 200 && ballX >= paddle2Xpos - 40 && ballY >= paddle2Ypos) {
    xSpeed = -xSpeed;
  }

  if (ballX > 800 || ballX < 0) {
    xSpeed = -xSpeed;
    p2Score = p2Score + 1;
    ballX = 400;
    ballY = 400;
  }
  if (ballY > 800 || ballY < 0) {
    ySpeed = -ySpeed;
  }
  if (ballX + 40 < 0 || ballX+40 > 800) {
    xSpeed = -xSpeed;
    p1Score = p1Score + 1;
    ballX = 400;
    ballY = 400;
  }
  if (ballY+40 < 0 || ballY+40 > 800) {
    ySpeed = -ySpeed;
  }
}

//Draws and intergrates collison for paddle 1
void paddle1() {
  if (moveUp1 == true && paddle1Ypos>-10) {
    paddle1Ypos = paddle1Ypos - 5;
  }
  if (moveDown1 == true && paddle1Ypos<650) {
    paddle1Ypos = paddle1Ypos + 5;
  }
  rect(paddle1Xpos, paddle1Ypos, 30, 150, 10);
}

//Draws and intergrates collison for paddle 2
void paddle2() {
  if (moveUp2 == true && paddle2Ypos>-10) {
    paddle2Ypos = paddle2Ypos - 5;
  }
  if (moveDown2 == true && paddle2Ypos<650) {
    paddle2Ypos = paddle2Ypos + 5;
  }
  rect(paddle2Xpos, paddle2Ypos, 30, 150, 10);
}

/*Reads key presses and performs actions depending on the key (This sets the
 moveUp and move Down variables to true)*/
void keyPressed() {
  if (keyCode ==  38) {
    moveUp1 = true;
  }
  if (keyCode ==  40) {
    moveDown1 = true;
  }
  if (keyCode ==  87) {
    moveUp2 = true;
  }
  if (keyCode ==  83) {
    moveDown2 = true;
  }
  if (keyCode ==  65) {
    start = true;
  }
}

/*Reads when a given key is released (This sets the moveUp and moveDown
 variables to false)*/
void keyReleased() {
  if (keyCode ==  38) {
    moveUp1 = false;
  }
  if (keyCode ==  40) {
    moveDown1 = false;
  }
  if (keyCode ==  87) {
    moveUp2 = false;
  }
  if (keyCode ==  83) {
    moveDown2 = false;
  }
}
