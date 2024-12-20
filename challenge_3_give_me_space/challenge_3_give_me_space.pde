SpaceShip player;
ArrayList<Astroid> astroids = new ArrayList();
ArrayList<Bullet> bullets = new ArrayList();

boolean isUpPressed = false;
boolean isLeftPressed = false;
boolean isRightPressed = false;

GameState state = GameState.IN_MENU;

JSONObject data;
int score = 0;
int frameDelta = 0;

PImage background;

void setup() {
  size(1400, 1000);
  data = loadJSONObject("data/data.json");
  background = loadImage("background.png");
  player = new SpaceShip(100, 100, new PVector(width/2, height / 2));
  textFont(createFont("Starjedi.ttf", 34));
  noStroke();
}

void draw() {

  background(background);

  for (Astroid astroid : astroids) {
    astroid.render();
  }

  if (state == GameState.PAUSED) {
    drawPauseMenu();
    return;
  }

  update();

  if (state == GameState.IN_MENU) {
    drawMenu();
    return;
  }

  if (state == GameState.GAME_OVER) {
    drawGameOverMenu();
    return;
  }

  player.render();

  // draw the bullets
  for (Bullet bullet : bullets) {
    bullet.render();
  }

  drawHUD();
}

void drawHUD() {
  textSize(24);
  text("health:\n\nscore:  " + score, 50, 68);


  stroke(255);
  fill(0);
  rect(170, 50, 200, 20);

  fill(255);
  rect(170, 50, 200 * player.getHealth() / player.getMaxHealth(), 20);
}

void drawMenu() {
  fill(0, 0, 0, 128);
  rect(0, 0, width, height);
  fill(255);

  textSize(128);
  textAlign(CENTER);
  text("give me\ns p a c e", width/2, height * 0.33);

  textSize(64);
  text("press 'space' to start", width/2, height * 0.55);
  
  textSize(36);
  text("high score: " + data.getInt("highscore"), width/2, height * 0.65);

  textSize(36);
  text("controls:\nwasd - move\nmouse - aim\nleft Mouse - shoot", width/2, height * 0.75);
  textAlign(LEFT);
}

void drawPauseMenu() {
  fill(0, 0, 0, 128);
  rect(0, 0, width, height);
  fill(255);

  textSize(128);
  textAlign(CENTER);
  text("give me\ns p a c e", width/2, height * 0.33);

  textSize(64);
  text("game paused", width/2, height * 0.55);

  textSize(48);
  text("Press 'space' to continue", width/2, height * 0.65);

  textAlign(LEFT);
}

void drawGameOverMenu() {
  fill(255, 0, 0, 128);
  rect(0, 0, width, height);
  fill(255);

  textSize(128);
  textAlign(CENTER);
  text("game over!", width/2, height * 0.33);
  textSize(64);
  text("Score: " + score, width/2, height * 0.55);

  textSize(48);
  text("Press 'space' to return to menu", width/2, height * 0.65);

  textAlign(LEFT);
}

void update() {

  if (isUpPressed) {
    player.addSpeed(0.25);
  }

  if (isRightPressed) {
    player.setAngularSpeed(5);
  }

  if (isLeftPressed) {
    player.setAngularSpeed(-5);
  }

  player.update();
  generateAstroid();

  // update the bullets
  ArrayList<Bullet> bulletToRemove = new ArrayList();

  for (int i = 0; i < bullets.size(); i++) {
    Bullet bullet = bullets.get(i);

    bullet.update();

    // check if the bullet should be removed
    PVector bulletPosition = bullet.getPosition();

    // Should be removed if colided with astroid
    for (Astroid astroid : astroids) {

      if (bulletPosition.dist(astroid.getPosition()) < bullet.getHitboxSize() / 2 + astroid.getSize() / 2) {
        bulletToRemove.add(bullets.get(i));
        astroid.removeHealth(1);
      }
    }

    // SHould be removed if off screen
    if (bulletPosition.x < 0 || bulletPosition.x > width || bulletPosition.y < 0 || bulletPosition.y > height) {
      bulletToRemove.add(bullets.get(i));
    }

    // remove the marked bullets and astroids
    bullets.removeAll(bulletToRemove);
  }

  // update the astroids
  ArrayList<Astroid> astroidToRemove = new ArrayList();

  for (int i = 0; i < astroids.size(); i++) {
    Astroid astroid = astroids.get(i);
    astroid.update();

    // check if the astroid should be removed
    PVector astroidPosition = astroid.getPosition();

    // should be removed if colided with spaceship
    if (astroidPosition.dist(player.getPosition()) < player.getHitboxSize() / 2 + astroid.getSize() / 2) {
      player.removeHealth(10);
      astroidToRemove.add(astroids.get(i));
    }

    // astroid without health should be removed
    if (astroid.health <= 0) {
      astroidToRemove.add(astroids.get(i));
      score += 100;
    }

    // should be removed if off screen
    if (astroidPosition.y < -250 || astroidPosition.y > height + 250 || astroidPosition.x < -250 || astroidPosition.x > width + 250) {
      astroidToRemove.add(astroids.get(i));
    }
  }

  // remove the marked astroids
  astroids.removeAll(astroidToRemove);

  if (player.getHealth() <= 0) {
    state = GameState.GAME_OVER;
  }

  if ((frameCount - frameDelta) > frameRate * 2 && state == GameState.RUNNING) {
    score += 150;
    frameDelta = frameCount;
  }
}


void generateAstroid() {

  int astroidCountMax = 100;

  if (astroids.size() > astroidCountMax) {
    return;
  }

  int health = int(random(1, 3));

  PVector position = new PVector();

  // randomizing the position on the edges of the screen
  // based on: https://stackoverflow.com/a/38167615

  int edgeDistance = 200;
  int rectWidth = width + edgeDistance * 2;
  int rectHeight = height + edgeDistance * 2;

  float p = random(0, 2* rectWidth + 2 * rectHeight);

  if (p < (rectWidth + rectHeight)) {
    if (p < rectWidth) {
      position.x = p - edgeDistance;
      position.y = -edgeDistance;
    } else {
      position.x = rectWidth - edgeDistance;
      position.y = p - rectWidth - edgeDistance;
    }
  } else {
    p = p - (rectWidth + rectHeight);
    if (p < rectWidth) {
      position.x = rectWidth - p - edgeDistance;
      position.y = rectHeight - edgeDistance;
    } else {
      position.x = - edgeDistance;
      position.y = rectHeight - (p - rectWidth) - edgeDistance;
    }
  }

  float size = random(20, 50);

  PVector velocity = new PVector(random(-2, 2), random(-2, 2));

  astroids.add(new Astroid(health, position, velocity, size));
}

void keyPressed() {

  switch(key) {
  case 'w':
    isUpPressed = true;
    break;
  case 'a':
    isLeftPressed = true;
    break;
  case 'd':
    isRightPressed = true;
    break;
  case ' ': // space
    if (state == GameState.RUNNING) {
      state = GameState.PAUSED;
    } else if (state == GameState.PAUSED) {
      state = GameState.RUNNING;
    } else if (state == GameState.IN_MENU) {
      resetGame();
      state = GameState.RUNNING;
    } else if (state == GameState.GAME_OVER) {
      state = GameState.IN_MENU;
      resetGame();
    }
  }
}

void keyReleased() {

  switch(key) {
  case 'w':
    isUpPressed = false;
    break;
  case 'a':
    isLeftPressed = false;
    break;
  case 'd':
    isRightPressed = false;
    break;
  }
}

void mousePressed() {
  int x = mouseX;
  int y = mouseY;

  bullets.addAll(player.fire(new PVector(x, y)));
}

void resetGame() {
  astroids = new ArrayList();
  bullets = new ArrayList();

  player = new SpaceShip(100, 100, new PVector(width/2, height / 2));
  
  if (score > data.getInt("highscore")) {
    data.setInt("highscore", score);
    saveJSONObject(data, "data/data.json");
  }

  score = 0;
  frameDelta = frameCount;
}
