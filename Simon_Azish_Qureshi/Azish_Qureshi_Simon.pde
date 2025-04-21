/*Azish Qureshi

 Simon 
 
 A memory game
 using light patterns
 made with OOP
 
 October 23, 2023*/

Button[] buttons;
int[] sequence = new int[50];
int sequenceIndex = 0;
int realTime;
int lengthTime = 500; //Speed of the game can be adjusted here
int subtractTime = 0;
int lastColour;
int gameState = 0; //0 = displaying sequence, 1 = clicking sequence, 2 = game over
int round = 1;

//Button colours
color[] c = {#FF0000, #FFF000, #0000FF, #008800};

void setup() {
  size(500, 500);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textSize(32);
  //Instanties 4 buttons
  buttons = new Button[4];
  for (int i = 0; i < buttons.length; i++) {
    buttons[i] = new Button(i, c[i], #FFFFFF);
  }
  for (int i = 0; i < sequence.length; i++) {
    sequence[i] = (int)random(4);
  }
}

void draw() {
  //Switch case for different game states
  switch(gameState) {
  case 0:
    drawBoard();
    sequenceDisplay();
    break;
  case 1:
    drawBoard();
    break;
  case 2:
    gameOver();
    break;
  }
}

//Runs code for when the player loses
void gameOver() {
  background(#000000);
  textSize(50);
  fill(buttons[lastColour].offColour);
  text("GAME OVER", 120, 240);
  textSize(20);
  fill(#FFFFFF);
  text("Close canvas to restart", 150, 270);
}

//Draws the entire board
void drawBoard() {
  background(#555555);
  for (Button button : buttons) {
    button.display();
  }
  fill(#FFFFFF);
  text("SIMON", 205, 260);
  text("SCORE:", 180, 40);
  text(round-1, 290, 40);
}

/*Checks where the mouse was pressed, and adds to the round if the player was correct
or ends the game if the player was incorrect*/
void mousePressed() {
  int colourFinder = (color(get(mouseX, mouseY)));   
  if (gameState == 1) {
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].checkMouse();
    }
    if (lastColour != sequence[sequenceIndex]) {
      //Ends the game if incorrect
      gameState = 2;
      if (colourFinder != buttons[lastColour].offColour){
    //Prevents the game from ending when the mouse is pressed out of bounds
    gameState = 1;  
    }
    } else {
      sequenceIndex++;
      if (sequenceIndex == round) {
        //It's the computer's turn
        gameState = 0;
        sequenceIndex = 0;
        round++;
        subtractTime = millis();
      }
    }
  }
}

//Resets the buttons when the mouse is released
void mouseReleased() {
  for (Button button : buttons) {
    button.reset();
  }
}

boolean userInput = false;

//Displays the sequence onto the buttons by turning them on and off
void sequenceDisplay() {
  realTime = millis();
  if (realTime - subtractTime >= lengthTime) {
    // Turn on button
    buttons[sequence[sequenceIndex]].isClicked = true;
  }
  if (realTime - subtractTime >= 1.5*lengthTime) {
    // Turn off button
    buttons[sequence[sequenceIndex]].isClicked = false;
    sequenceIndex++;
    subtractTime = millis();
  }
  if (sequenceIndex == round) {
    //It's the player's turn
    gameState = 1;
    sequenceIndex = 0;
  }
}
