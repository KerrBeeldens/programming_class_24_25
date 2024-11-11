import java.util.*;

// Define some 'global' variables
final color SHADE_1 = color(132, 140, 77);
final color SHADE_2 = color(92, 98, 54);
final color SHADE_3 = color(53, 56, 31);
final color SHADE_4 = color(13, 14, 8);

final int PIXEL_SIZE = 4;
final int SQUARE_SIZE = PIXEL_SIZE * 8;

final int FIELD_X_SIZE = 10;
final int FIELD_Y_SIZE = 24;

GameState state = GameState.LAUNCHED;

Field field = new Field(FIELD_X_SIZE, FIELD_Y_SIZE);
TetronominoType[] tetronominoTypes = {TetronominoType.O_TYPE,
                                      TetronominoType.I_TYPE,
                                      TetronominoType.S_TYPE,
                                      TetronominoType.Z_TYPE,
                                      TetronominoType.L_TYPE,
                                      TetronominoType.J_TYPE,
                                      TetronominoType.T_Type};
                                      
Tetronomino currentTetronomino = new Tetronomino(field, tetronominoTypes[int(random(tetronominoTypes.length))]);
Tetronomino nextTetronomino = new Tetronomino(field, new PVector(15, 17), tetronominoTypes[int(random(tetronominoTypes.length))]);

int[] scoreLookup = new int[] {0, 40, 100, 300, 1200};
JSONObject data;
int score = 0;
int level = 0;
int lines = 0;
int speed = 60;

// variables in the size method requires the settings() method
void settings() {
 size(FIELD_X_SIZE * SQUARE_SIZE + 14 * SQUARE_SIZE, FIELD_Y_SIZE * SQUARE_SIZE);
}

// font loading requires the setup function (frustratingly)
void setup() {
  textFont(createFont("tetris-gb.ttf", 34));
  data = loadJSONObject("data/data.json");
}

void draw() {
  // update the application
  update();

  // Start drawing
  background(SHADE_4);

  // Draw the score boards
  drawScore("score", score, new PVector(6 * SQUARE_SIZE + SQUARE_SIZE * FIELD_X_SIZE, SQUARE_SIZE));
  drawStats("level", level, new PVector(6 * SQUARE_SIZE + SQUARE_SIZE * FIELD_X_SIZE, SQUARE_SIZE * 7));
  drawStats("lines", lines, new PVector(6 * SQUARE_SIZE + SQUARE_SIZE * FIELD_X_SIZE, SQUARE_SIZE * 11));
  
  // draw the "next tetromino" board
  drawNextTetromino();
  
  // draw the field and tetronomino
  field.drawField();
  currentTetronomino.drawTetronomino();
  
  // draw the menu if applicabble
  drawStartScreen();
}





void drawScore(String name, int value, PVector position) {
  
  noStroke();
  fill(SHADE_1);
  rect(int(position.x) - SQUARE_SIZE * 2, int(position.y) + SQUARE_SIZE, 10 * SQUARE_SIZE, 3 * SQUARE_SIZE);
  
  fill(SHADE_3);
  rect(int(position.x) - SQUARE_SIZE * 2, int(position.y) + SQUARE_SIZE + PIXEL_SIZE, 10 * SQUARE_SIZE, 1.5 * SQUARE_SIZE);
  
  strokeWeight(PIXEL_SIZE);
  stroke(SHADE_1);
  line(int(position.x) - SQUARE_SIZE * 2, int(position.y) + 2 * SQUARE_SIZE + 3 * PIXEL_SIZE, int(position.x) - SQUARE_SIZE * 2 + 10 * SQUARE_SIZE, int(position.y) + 2 * SQUARE_SIZE + 3 * PIXEL_SIZE);
  
  stroke(SHADE_3);
  line(int(position.x) - SQUARE_SIZE * 2, int(position.y) + 4 * SQUARE_SIZE - 2 * PIXEL_SIZE, int(position.x) - SQUARE_SIZE * 2 + 10 * SQUARE_SIZE, int(position.y) + 4 * SQUARE_SIZE - 2 * PIXEL_SIZE);
  
  fill(SHADE_4);
  textAlign(RIGHT);
  text(value, int(position.x) + SQUARE_SIZE/2 + 34 * 5, int(position.y) + 4 * SQUARE_SIZE - 14);
  
  stroke(SHADE_1);
  rect(int(position.x), int(position.y), 6 * SQUARE_SIZE, 2 * SQUARE_SIZE);
  
  stroke(SHADE_3);
  fill(SHADE_1);
  rect(int(position.x + PIXEL_SIZE), int(position.y + PIXEL_SIZE), 6 * SQUARE_SIZE - 2 * PIXEL_SIZE, 2 * SQUARE_SIZE - 2 * PIXEL_SIZE);
  
  fill(SHADE_4);
  textAlign(LEFT);
  text(name, int(position.x) + SQUARE_SIZE/2, int(position.y) + 2 * SQUARE_SIZE - 20);
}

void drawStats(String name, int value, PVector position) {
  stroke(SHADE_1);
  rect(int(position.x), int(position.y), 6 * SQUARE_SIZE, 3 * SQUARE_SIZE);
  
  stroke(SHADE_3);
  fill(SHADE_1);
  rect(int(position.x + PIXEL_SIZE), int(position.y + PIXEL_SIZE), 6 * SQUARE_SIZE - 2 * PIXEL_SIZE, 3 * SQUARE_SIZE - 2 * PIXEL_SIZE);
  
  fill(SHADE_4);
  textAlign(LEFT);
  text(name, int(position.x) + SQUARE_SIZE/2, int(position.y) + 3 * SQUARE_SIZE / 2 - 5);
  
  textAlign(RIGHT);
  text(value, int(position.x) + SQUARE_SIZE/2 + 34 * 4, int(position.y) + 3 * SQUARE_SIZE - 17);
}

void drawNextTetromino() {
  PVector position = new PVector(6 * SQUARE_SIZE + SQUARE_SIZE * FIELD_X_SIZE, SQUARE_SIZE * 16);
  
  stroke(SHADE_2);
  rect(int(position.x), int(position.y), 6 * SQUARE_SIZE, 6 * SQUARE_SIZE);
  
  stroke(SHADE_1);;
  rect(int(position.x) + PIXEL_SIZE, int(position.y) + PIXEL_SIZE, 6 * SQUARE_SIZE - 2 * PIXEL_SIZE, 6 * SQUARE_SIZE - 2 * PIXEL_SIZE);
  
  stroke(SHADE_3);;
  rect(int(position.x) + 2 * PIXEL_SIZE, int(position.y) + 2 * PIXEL_SIZE, 6 * SQUARE_SIZE - 4 * PIXEL_SIZE, 6 * SQUARE_SIZE - 4 * PIXEL_SIZE);
  
  stroke(SHADE_4);
  fill(SHADE_1);
  rect(int(position.x) + 3 * PIXEL_SIZE, int(position.y) + 3 * PIXEL_SIZE, 6 * SQUARE_SIZE - 6 * PIXEL_SIZE, 6 * SQUARE_SIZE - 6 * PIXEL_SIZE);
  
  nextTetronomino.drawTetronomino();
}











void drawStartScreen() {
  
  String menuText;
  
  switch (state) {
    case PAUSED:
      menuText = String.format("high score\n%d\n\nscore\n%d", data.getInt("highscore"), score);
      startScreen("game paused", menuText);
      break;
    case GAME_OVER:
      menuText = String.format("high score\n%d\n\nfinal score\n%d", data.getInt("highscore"), score);
      startScreen("game over", menuText);
      break;
    case LAUNCHED:
      menuText = String.format("high score\n%d\n\npress enter\nto play", data.getInt("highscore"));
      startScreen("new game", menuText);
       break;
  }
}

void startScreen(String menuTitle, String menuText) {
  rectMode(CENTER);
  textAlign(CENTER);
  
  // Menu background
  int menuWidth = 14 * SQUARE_SIZE;
  int menuHeight = 10 * SQUARE_SIZE;
  
  fill(SHADE_2);
  stroke(SHADE_4);
  rect(width/2, height/2, menuWidth, menuHeight);
  
  stroke(SHADE_2);
  rect(width/2, height/2, menuWidth, menuHeight);
  
  stroke(SHADE_1);
  rect(width/2, height/2, menuWidth - 2 * PIXEL_SIZE, menuHeight - 2 * PIXEL_SIZE);
  
  stroke(SHADE_3);
  rect(width/2, height/2, menuWidth - 4 * PIXEL_SIZE, menuHeight - 4 * PIXEL_SIZE);
  
  stroke(SHADE_4);
  fill(SHADE_1);
  rect(width/2, height/2, menuWidth - 6 * PIXEL_SIZE, menuHeight - 6 * PIXEL_SIZE);
  
  // Menu title
  fill(SHADE_4);
  text(menuTitle.toUpperCase(), width/2, height/2 - 3 * SQUARE_SIZE);
  line(width/2 - menuWidth/3, height/2 - 2.5 * SQUARE_SIZE, width/2 + menuWidth/3,  height/2 - 2.5 * SQUARE_SIZE);
  
  // Menu content
  text(menuText.toLowerCase(), width/2, height/2 - 2 * PIXEL_SIZE);
  
  rectMode(CORNER);
}

void update() {
  
  // Simple implementation to create a constant tickrate, assuming constant framerate
  if (frameCount % speed == 0 && state == GameState.RUNNING) {
    // move the active tetronomino down, if possible
    moveDown();
  }
}

// TODO: improve
void keyPressed() {
  if (state == GameState.RUNNING) {
  switch (keyCode) {
    case LEFT:
      moveLeft();
      break;
    case RIGHT:
      moveRight();
      break;
    case DOWN:
      moveDown();
      break;
    case UP:
      rotatePiece();
      break;
    }
  }
  
  if (keyCode == ENTER) { 
    switch (state) {
      case RUNNING:
        state = GameState.PAUSED;
        break;
      case PAUSED:
        state = GameState.RUNNING;
        break;
      case GAME_OVER:
        state = GameState.LAUNCHED;
        reset();
        break;
      case LAUNCHED:
        state = GameState.RUNNING;
        break;
    }
  }
}

void moveLeft() {
  currentTetronomino.moveLeft();
}

void moveRight() {
  currentTetronomino.moveRight();
}

// TODO: split this function
void moveDown() {
  // move the active tetronomino down, if possible
  boolean canMove = currentTetronomino.moveDown();
  
  if(!canMove) {
    
    HashSet<Integer> addedRows = new HashSet<Integer>();
    
    // The tetronomino cannot move down, add all its squares to the field
    for (Square square: currentTetronomino.getSquares()) {
      field.addSquare(square);   
      addedRows.add(int(square.position.y));
    }
    
    // Check if any of the rows a square was added to are full and remove them
    
    int rowsCleared = 0;
    
    for (int row : addedRows) {
      if (field.isRowFull(row)) {
        field.removeRow(row);
        rowsCleared++;
      }
    }
    
    // update the score, lines and level
    score += scoreLookup[rowsCleared] * (level + 1);
    lines += rowsCleared;
    
    level += (lines >= (level + 1) * 2) ? 1 : 0;
    speed = int(max(frameRate - frameRate/12 * level, 4));
    
    // Create a new tetronomino
    currentTetronomino = new Tetronomino(field, nextTetronomino.getType());
    nextTetronomino = new Tetronomino(field, new PVector(15, 17), tetronominoTypes[int(random(tetronominoTypes.length))]);
    
    // check for game over
    for (Square square : currentTetronomino.getSquares()) {
      if(!field.isEmpty(square.getPosition())) {
        state = GameState.GAME_OVER;
        
        if (data.getInt("highscore") < score) {
          data.setInt("highscore", score);
          saveJSONObject(data, "data/data.json");
        }
        
        currentTetronomino.drawTetronomino();  
        drawStartScreen();
      }
    }
  }
}

void rotatePiece() {
  currentTetronomino.rotatePiece();
}

void reset() {
  score = 0;
  lines = 0;
  level = 0;
  
  field = new Field(FIELD_X_SIZE, FIELD_Y_SIZE);
  currentTetronomino = new Tetronomino(field, tetronominoTypes[int(random(tetronominoTypes.length))]);
  nextTetronomino = new Tetronomino(field, new PVector(15, 17), tetronominoTypes[int(random(tetronominoTypes.length))]);
}
