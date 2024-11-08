public class Canvas {
 
  private PVector position;
  private int pixelSize;
  
  private PVector cursor;
  private boolean[][] canvas;
  
  private color backgroundColor = color(128);
  private color drawColor = color(64);
  private color cursorColor = color(255); 
  
  public Canvas(PVector position, int pixelSize, int canvasWidth, int canvasHeight, PVector startingPoint) {
   this.position = position;
   this.pixelSize = pixelSize;
   
   this.cursor = startingPoint;
   this.canvas = new boolean[canvasWidth][canvasHeight];
  }
  
  
  public void render() {
    noStroke();
    
    for (int x = 0; x < canvas.length - 1; x++) {
     for (int y = 0; y < canvas[0].length - 1; y++) {
       color fillColor = canvas[x][y] ? drawColor : backgroundColor;
       fill(fillColor);
       square(x * (pixelSize + 1) + position.x, y * (pixelSize + 1) + position.y, pixelSize);
     }
    }
    
    fill(cursorColor);
    square(cursor.x * (pixelSize + 1) + position.x, cursor.y * (pixelSize + 1) + position.y, pixelSize);
  }
  
  private int sign(int number) {
  if (number > 0) return 1;
  if (number < 0) return -1;
  return 0;
} 
  
  public void addPoint(PVector point) {
    int pointX = int(point.x);
    int pointY = int(point.y);
    
    int deltaX = pointX - int(cursor.x);
    int deltaY = pointY - int(cursor.y);
    
    int signDeltaX = sign(deltaX);
    int signDeltaY = sign(deltaY);
    
    if (deltaX == 0 ^ deltaY == 0) {
      for(int x = 0; x <= abs(deltaX); x++) {
            canvas[pointX - signDeltaX * x][pointY] = true;
      }
      
      for(int y = 0; y <= abs(deltaY); y++) {
        canvas[pointX][pointY - signDeltaY * Y] = true;
      }
    }
    cursor = new PVector(int(point.x), int(point.y));
  }
  
  public void clear() {
    int canvasWidth = canvas.length;
    int canvasHeight = canvas[0].length;
    this.canvas = new boolean[canvasWidth][canvasHeight];
  }
}
