public class Field {
 
  private Square[][] squares; 

  public Field(int fieldWidth, int fieldHeight) {
    squares = new Square[fieldHeight][fieldWidth];
  }
    
  public void drawField() {
    int xOffset = 3 * SQUARE_SIZE;
    
    // draw the bricks on the sides
    drawBricks(SQUARE_SIZE * 2, false); // left
    drawBricks(SQUARE_SIZE * 2 + FIELD_X_SIZE * SQUARE_SIZE, true); // right

    // Set the background
    noStroke();
    fill(SHADE_1);
    rect(xOffset, 0, SQUARE_SIZE * FIELD_X_SIZE + PIXEL_SIZE, FIELD_Y_SIZE * SQUARE_SIZE);
    
    // Draw the squares on the field
    for(Square[] squareArray : squares) {
      for (Square square : squareArray) {
        if (square != null) {
          square.drawSquare();
        }
      }
    }
  }
  
  private void drawBricks(int startX, boolean mirror) {
    
    int brickHeight = 4 * PIXEL_SIZE;
    int brickWidth = 5 * PIXEL_SIZE;
    
    for (int x = 0; x < 3; x++) {
      for (int y = 0; y < FIELD_Y_SIZE * 2; y++) {
        
        int sign = mirror ? -1 : 1;
        int xOffset = (y % 2 == 0) ? startX - sign * PIXEL_SIZE * 2 : startX;
        
        // main brick
        strokeWeight(PIXEL_SIZE);
        stroke(SHADE_4);
        fill(SHADE_2);
        rect(xOffset + x * brickWidth, y * brickHeight, brickWidth, brickHeight);
        
        // highlight
        noStroke();
        fill(SHADE_1);
        rect(xOffset + PIXEL_SIZE + x * brickWidth, PIXEL_SIZE + y * brickHeight, PIXEL_SIZE, PIXEL_SIZE);
      }
    }
  }
  
  public void addSquare(Square addedSquare) {
    squares[int(addedSquare.getPosition().y)][int(addedSquare.getPosition().x)] = addedSquare;
  }
  
  public boolean isRowFull(int row) {
    for (Square square : squares[row]) {
      if (square == null) {
        return false;
      }
    }
    return true;
  }
  
  public void removeRow(int row) {
    // Shift all rows above the specified row down by one
    for (int y = row; y > 0; y--) {
      squares[y] = squares[y - 1];
      
      // update the coordinates of the squares
      for (Square square : squares[y]) {
        if (square != null) {square.moveDown();}
      }
    }
   
    // Set the top row to a clear row
    squares[0] = new Square[FIELD_X_SIZE]; 
  }
  
  public boolean isEmpty(PVector position) {
    return squares[int(position.y)][int(position.x)] == null;
  }
}
