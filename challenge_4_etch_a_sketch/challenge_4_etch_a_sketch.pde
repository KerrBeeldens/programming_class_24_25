
Dial leftDial;
Dial rightDial;
Canvas canvas;

void setup() {
  size(1400, 1000);

  leftDial = new Dial(new PVector(150, height - 100), 50, 0, 240, 15f);
  rightDial = new Dial(new PVector(width - 150, height - 100), 50, 0, 120, 15f);
  canvas = new Canvas(new PVector(100, 100), 5, 240, 140, new PVector(0, 0));

  textFont(createFont("Clouts!.ttf", 85));
  textAlign(CENTER);
}

void draw() {
  background(160, 25, 25);

  fill(187, 165, 61);
  text("Etch a Sketch", width / 2, height - 75);

  canvas.render();
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
