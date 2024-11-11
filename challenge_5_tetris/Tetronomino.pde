public class Tetronomino {
  
  private PVector position;
  private Square[] squares;
  private TetronominoType type;
  
  private Field field;
  
  public Tetronomino(Field field, TetronominoType type) {
    this(field, new PVector(4 , 0), type);
  }
  
  public Tetronomino(Field field, PVector position, TetronominoType type) {
    this.field = field;
    this.type = type;
    this.position = position;
    
    int xPosition = int(position.x);
    int yPosition = int(position.y);
    
    switch (type) {
      case O_TYPE:
        squares = new Square[]{new Square(new PVector(xPosition, yPosition), type), 
                               new Square(new PVector(xPosition + 1, yPosition), type),
                               new Square(new PVector(xPosition, yPosition + 1), type), 
                               new Square(new PVector(xPosition + 1, yPosition + 1), type)};
        break;
      case I_TYPE:
        squares = new Square[]{new Square(new PVector(xPosition - 1, yPosition), type), 
                               new Square(new PVector(xPosition, yPosition), type), 
                               new Square(new PVector(xPosition + 1, yPosition), type), 
                               new Square(new PVector(xPosition + 2, yPosition), type)};
        break;
      case S_TYPE:
        squares = new Square[]{new Square(new PVector(xPosition - 1, yPosition + 1), type), 
                               new Square(new PVector(xPosition, yPosition + 1), type), 
                               new Square(new PVector(xPosition, yPosition), type), 
                               new Square(new PVector(xPosition + 1, yPosition), type)};
        break;
      case Z_TYPE:
        squares = new Square[]{new Square(
                               new PVector(xPosition - 1, yPosition), type), 
                               new Square(new PVector(xPosition, yPosition), type), 
                               new Square(new PVector(xPosition, yPosition + 1), type), 
                               new Square(new PVector(xPosition + 1, yPosition + 1), type)};
        break;
      case L_TYPE:
        squares = new Square[]{new Square(new PVector(xPosition, yPosition), type), 
                               new Square(new PVector(xPosition - 1, yPosition), type), 
                               new Square(new PVector(xPosition + 1, yPosition), type), 
                               new Square(new PVector(xPosition - 1, yPosition + 1), type)};
        break;
      case J_TYPE:
        squares = new Square[]{new Square(new PVector(xPosition, yPosition), type), 
                               new Square(new PVector(xPosition - 1, yPosition), type), 
                               new Square(new PVector(xPosition + 1, yPosition), type), 
                               new Square(new PVector(xPosition + 1, yPosition + 1), type)};
        break;
      case T_Type:
        squares = new Square[]{new Square(new PVector(xPosition - 1, yPosition), type), 
                               new Square(new PVector(xPosition, yPosition), type), 
                               new Square(new PVector(xPosition, yPosition + 1), type), 
                               new Square(new PVector(xPosition + 1, yPosition), type)};
        break;
      }
    }
  
  public void drawTetronomino() {
    for(Square square : squares) {
      square.drawSquare();
    }
  }
  
  public boolean moveDown() {
    for(Square square : squares) {
      PVector position = square.getPosition();
      
      // Check if the Tetronomino is on the floor
      if (position.y >= FIELD_Y_SIZE - 1) {
        return false;
      }
      
      // Check if the Tetronomino is blocked by another square
      if (!field.isEmpty(new PVector(position.x, position.y + 1))) {
        return false;
      }
    }
    
    // if all squares are allowed to move down, move them
    for(Square square : squares) {
      square.moveDown();
    }
    
    position.y++;
    
    return true;
  }
  
  public boolean moveLeft() {
    for(Square square : squares) {
      PVector position = square.getPosition();
      
      // check if the tetronomino is to on the edge
      if (position.x <= 0) {
        return false;
      }
      
      // Check if the Tetronomino is blocked by another suqare
      if (!field.isEmpty(new PVector(position.x - 1, position.y))) {
        return false;
      }
    }
    
    // if all squares are allowed to move down, move them
    for(Square square : squares) {
      square.moveLeft();
    }
    
    position.x--;
    
    return true;
  }
  
  public boolean moveRight() {
    for(Square square : squares) {
      PVector position = square.getPosition();
      
      // check if the tetronomino is to on the edge
      if (position.x >= FIELD_X_SIZE - 1) {
        return false;
      }
      
      // Check if the Tetronomino is blocked by another suqare
      if (!field.isEmpty(new PVector(position.x + 1, position.y))) {
        return false;
      }
    }
    
    // if all squares are allowed to move down, move them
    for(Square square : squares) {
      square.moveRight();
    }
    
    position.x++;
    
    return true;
  }
  
  public boolean rotatePiece() {
    
    PVector[] squarePositions = new PVector[4];
    
    // The I type requires a different algorithm
    if (type == TetronominoType.I_TYPE) {
      int i = 0;
      
      for(Square square : squares) {
        float squareX = square.getPosition().x - position.x + 0.5;
        float squareY = square.getPosition().y - position.y + 0.5;
        squarePositions[i] = new PVector(int(squareY + position.x + 0.5), int(-squareX + position.y + 0.5));
        i++;
      }
    } 
    
    else if (type != TetronominoType.O_TYPE) { 
      int i = 0;
      
      for(Square square : squares) {
        int squareX = int(square.getPosition().x - position.x);
        int squareY = int(square.getPosition().y - position.y);
        squarePositions[i] = new PVector(squareY + position.x, -squareX + position.y);
        i++;
      }
    } else {
      //the O type does not rotate and is excluded
      return true;
    }
    
    // check if rotation is allowed 
    for(PVector position : squarePositions) {
      
      // check boundaries
      if (position.x < 0 || position.x >= FIELD_X_SIZE - 1) {return false;}
      if (position.y < 0 || position.y >= FIELD_Y_SIZE - 1) {return false;}
 
      // check for collission
      if (!field.isEmpty(new PVector(position.x, position.y))) {
        return false;
      }
    }
    
    // rotation is allowed so apply it
    int i = 0;
    for(Square square : squares) {
      square.setPosition(squarePositions[i]);
      i++;
    }
    
    return true;
  }
  
  public Square[] getSquares() {return squares;}
  public TetronominoType getType() {return type;}
}
