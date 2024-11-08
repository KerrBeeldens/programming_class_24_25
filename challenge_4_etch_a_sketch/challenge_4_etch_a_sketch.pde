
Dial leftDial = new Dial(new PVector(150, 600), 50, 0, 200, 20f);
Dial rightDial = new Dial(new PVector(1120, 600), 50, 0, 75, 8f);
Canvas canvas = new Canvas(new PVector(140, 140), 4, 200, 75, new PVector(0, 0));

void setup() {
  size(1280, 720);
  frameRate(120);
}

void draw() {
  noStroke();
  fill(164, 26, 39);
  rect(40, 40, 1190, 640, 40);
  fill(196, 31, 35);
  rect(50, 50, 1170, 620, 30);
  fill(64);
  rect(140, 140, 1000, 375);
  canvas.render();
  noFill();
  stroke(64);
  strokeWeight(12);
  rect(135, 135, 1010, 385, 20);
  
  strokeWeight(3);
  stroke(0);
 
 leftDial.render(); 
 rightDial.render();
}

void mousePressed() {
  leftDial.onMousePressed(new PVector(mouseX, mouseY)); 
  rightDial.onMousePressed(new PVector(mouseX, mouseY));
}

void mouseDragged() {
  leftDial.onMouseDragged(new PVector(mouseX, mouseY)); 
  rightDial.onMouseDragged(new PVector(mouseX, mouseY));
  
  canvas.addPoint(new PVector(leftDial.getValue(), rightDial.getValue()));
  } 
