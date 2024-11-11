public class Square {
 
  private PVector position;
  private TetronominoType type;
  
  public Square(PVector position, TetronominoType type) {
    this.position = position;
    this.type = type;
  }
  
  public void drawSquare() {
    int xPosition = int(SQUARE_SIZE * 3 + position.x * SQUARE_SIZE);
    int yPosition = int(position.y * SQUARE_SIZE);
  
    stroke(SHADE_4);
    strokeWeight(PIXEL_SIZE);
    strokeCap(PROJECT);
    
    // yeah ... this could be better
    switch (type) {
      case O_TYPE:
        fill(SHADE_1);
        rect(xPosition, yPosition, SQUARE_SIZE, SQUARE_SIZE);
        fill(SHADE_4);
        rect(xPosition + PIXEL_SIZE * 2, yPosition + PIXEL_SIZE * 2, SQUARE_SIZE - PIXEL_SIZE * 4, SQUARE_SIZE - PIXEL_SIZE * 4);
        break;
      case I_TYPE:
        fill(SHADE_3);
        rect(xPosition, yPosition, SQUARE_SIZE, SQUARE_SIZE);
        break;
      case S_TYPE:
        fill(SHADE_3);
        rect(xPosition, yPosition, SQUARE_SIZE, SQUARE_SIZE);
        fill(SHADE_1);
        rect(xPosition + PIXEL_SIZE * 2, yPosition + PIXEL_SIZE * 2, SQUARE_SIZE - PIXEL_SIZE * 4, SQUARE_SIZE - PIXEL_SIZE * 4);
        break;
      case Z_TYPE:
        fill(SHADE_2);
        rect(xPosition, yPosition, SQUARE_SIZE, SQUARE_SIZE);
        fill(SHADE_4);
        rect(xPosition + PIXEL_SIZE * 3, yPosition + PIXEL_SIZE * 3, SQUARE_SIZE - PIXEL_SIZE * 6, SQUARE_SIZE - PIXEL_SIZE * 6);
        break;
      case L_TYPE:
        fill(SHADE_2);
        rect(xPosition, yPosition, SQUARE_SIZE, SQUARE_SIZE);
        break;
      case J_TYPE:
        fill(SHADE_2);
        rect(xPosition, yPosition, SQUARE_SIZE, SQUARE_SIZE);
        fill(SHADE_1);
        rect(xPosition + PIXEL_SIZE * 2, yPosition + PIXEL_SIZE * 2, SQUARE_SIZE - PIXEL_SIZE * 4, SQUARE_SIZE - PIXEL_SIZE * 4);
        break;
      case T_Type:
        fill(SHADE_2);
        rect(xPosition, yPosition, SQUARE_SIZE, SQUARE_SIZE);
        rect(xPosition + PIXEL_SIZE * 2, yPosition + PIXEL_SIZE * 2, SQUARE_SIZE - PIXEL_SIZE * 4, SQUARE_SIZE - PIXEL_SIZE * 4);
        stroke(SHADE_1);
        line(xPosition + PIXEL_SIZE * 2, yPosition + PIXEL_SIZE * 2, xPosition + PIXEL_SIZE * 2 + PIXEL_SIZE * 4, yPosition + PIXEL_SIZE * 2);
        line(xPosition + PIXEL_SIZE * 2, yPosition + PIXEL_SIZE * 2, xPosition + PIXEL_SIZE * 2, yPosition + PIXEL_SIZE * 2 + PIXEL_SIZE * 3);
        break;
    }
    
  }
  
  public void moveDown() {
    position.y++;
  }
  
  public void moveLeft() {
    position.x--;
  }
  
  public void moveRight() {
    position.x++;
  }
  
  public void setPosition(PVector position) {this.position = position;}
  
  public PVector getPosition() {return position;}
}
