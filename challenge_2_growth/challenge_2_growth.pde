
PShape flowerPot;
PShape grass;

void setup() {
  frameRate(30);
  size(1000, 1000);

  flowerPot = createFlowerPot(int(width / 2), int(height * 0.8));
  grass = createGrass(int(width / 2), int(height * 0.9));
  
  textAlign(CENTER);
}


void draw() {
  background(185, 218, 227);
  shape(grass);
  shape(flowerPot);
  drawStem(int(width / 2), int(height) - 300);
  drawLeaf(width / 2, int(height) - 375, true);
  drawLeaf(width / 2, int(height) - 425, false);
  drawPedals(int(width / 2), int(height) - 610);
  drawFlower(int(width / 2), int(height) - 610);
  drawFlowerFace(int(width / 2), int(height) - 610);

  if (frameCount > 235) {
    textSize(128);
    fill(0);
    text("Hello World!", width / 2, 120);
    
    textSize(20);
    text("\"Growth\" by Kerr", 250, 150);
  }
}

PShape createGrass(int xPosition, int yPosition) {

  PShape grass = createShape(GROUP);

  color grassLight = color(144, 173, 83);
  color grassDark = color(84, 122, 75);

  rectMode(CENTER);

  fill(grassLight);

  PShape base = createShape(ELLIPSE, xPosition, yPosition, width * 1.5, 0.3 * height);

  grass.addChild(base);

  return grass;
}


void drawStem(int startX, int startY) {
  rectMode(CORNER);
  fill(84, 122, 75);
  rect(startX - 7.5, startY, 15, min(frameCount, 155) * -2, 0);
}

void drawLeaf(int xPosition, int yPosition, boolean isLeftHanded) {

  if (frameCount < 50 && isLeftHanded || frameCount < 75 && !isLeftHanded) {
    return;
  }

  color grassLight = color(144, 173, 83);
  color grassDark = color(84, 122, 75);
  fill(grassDark);

  int operator = isLeftHanded ? 1 : -1;

  float scale = isLeftHanded ? max(min((frameCount - 50) / 50f, 1.25), 0) : max(min((frameCount - 75) / 50f, 1.25), 0);

  float rotationOffset = frameCount > 235 && !isLeftHanded ? cos(frameCount / 10f) * QUARTER_PI * 0.5 : 0; // the start value 235 was calculated using ChatGPT

  pushMatrix();
  translate(xPosition, yPosition);
  rotate((QUARTER_PI / 2 + rotationOffset) * operator);

  // base shape
  beginShape();
  vertex(0, 0);

  bezierVertex(-25 * scale * operator, 35 * scale, -65 * scale  * operator, 25 * scale, -100 * scale  * operator, 0);
  bezierVertex(-65 * scale  * operator, -25 * scale, -25 * scale  * operator, -35 * scale, 0, 0);
  endShape();

  // shading
  fill(grassLight);

  beginShape();
  vertex(0, 0);

  bezierVertex(-25 * scale * operator, 35 * scale, -65 * scale  * operator, 25 * scale, -100 * scale  * operator, 0);
  endShape();

  popMatrix();
}

void drawFlower(int startX, int startY) {

  if (frameCount < 155) {
    return;
  }

  fill(160, 75, 44);
  circle(startX, startY, min((frameCount - 155) * 3, 125));
}

void drawPedals(int xPosition, int yPosition) {

  if (frameCount < 200) {
    return;
  }

  ellipseMode(CENTER);

  pushMatrix();
  translate(xPosition, yPosition);

  for (int i = 0; i < 10; i++) {
    rotate(TWO_PI / 10);
    fill(235, 190, 16);
    ellipse(50, 0, min((frameCount - 200) * 3, 125), min((frameCount - 200) * 3, 50));
  }

  rotate(TWO_PI / 20);

  for (int i = 0; i < 10; i++) {

    rotate(TWO_PI / 10);
    fill(239, 215, 28);
    ellipse(50, 0, min((frameCount - 200) * 3, 125), min((frameCount - 200) * 3, 50));
  }

  popMatrix();
}

void drawFlowerFace(int xPosition, int yPosition) {

  if (frameCount < 155) {
    return;
  }


  pushMatrix();

  translate(xPosition, yPosition);
  scale(max(min((frameCount - 155) / 41.6f, 1), 0));

  // left side
  fill(255);
  ellipse(-30, -25, 25, 35);
  fill(0);
  circle(-28, -20, 10);
  fill(239, 141, 104);
  ellipse(-40, +10, 25, 15);

  // right side
  fill(255);
  ellipse(+30, -25, 25, 35);
  fill(0);
  circle(28, -20, 10);
  fill(239, 141, 104);
  ellipse(+40, +10, 25, 15);

  // mouth
  noFill();
  arc(0, 0, 25, 25, 0, PI);

  popMatrix();
}


PShape createFlowerPot(int xPosition, int yPosition) {

  PShape flowerPot = createShape(GROUP);

  // Init colors
  color potLight = color(160, 75, 44);
  color potDark = color(96, 45, 26);

  rectMode(CENTER);

  stroke(0);
  strokeWeight(2);
  fill(potLight);

  PShape topRim = createShape(ELLIPSE, xPosition, yPosition - 115, 250, 50);

  PShape middleRim = createShape();
  middleRim.beginShape();
  middleRim.vertex(xPosition - 125, yPosition - 115);
  middleRim.vertex(xPosition - 120, yPosition - 50);
  middleRim.vertex(xPosition + 120, yPosition - 50);
  middleRim.vertex(xPosition + 125, yPosition - 115);
  middleRim.endShape();

  PShape bottomRim = createShape();
  bottomRim.beginShape();
  bottomRim.vertex(xPosition - 100, yPosition - 50);
  bottomRim.vertex(xPosition - 90, yPosition + 50);
  bottomRim.vertex(xPosition + 90, yPosition + 50);
  bottomRim.vertex(xPosition + 100, yPosition - 50);
  bottomRim.endShape();

  // fix some arcs
  PShape middleRimArc = createShape(ARC, xPosition, yPosition - 52, 240, 50, 0, PI);
  PShape bottomRimArc = createShape(ARC, xPosition, yPosition + 48, 180, 50, 0, PI);

  // Add earth
  fill(potDark);
  PShape earthTop = createShape(ARC, xPosition, yPosition - 102, 200, 35, PI - 0.1, 2 * PI + 0.1);
  PShape earthBottom = createShape(ARC, xPosition, yPosition - 115, 250, 50, 0.2 * PI, 0.8 * PI);

  flowerPot.addChild(bottomRim);
  flowerPot.addChild(middleRim);
  flowerPot.addChild(topRim);
  flowerPot.addChild(middleRimArc);
  flowerPot.addChild(bottomRimArc);
  flowerPot.addChild(earthTop);
  flowerPot.addChild(earthBottom);


  return flowerPot;
}
