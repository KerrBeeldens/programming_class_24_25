
int level = 1;

SpaceShip player;
ArrayList<Astroid> astroids = new ArrayList();
ArrayList<Bullet> bullets = new ArrayList();


boolean isUpPressed = false;
boolean isLeftPressed = false;
boolean isRightPressed = false;

GameState state = GameState.IN_MENU;

void setup() {
  size(1600, 1200);

  player = new SpaceShip(100, 100, 100, 100, 1000, new PVector(width/2, height / 2));
}

void draw() {

  if (state == GameState.IN_MENU) {
    drawMenu();
    return;
  }

  if (state == GameState.PAUSED) {
    drawPauseMenu();
    return;
  }

  if (state == GameState.GAME_OVER) {
    drawGameOverMenu();
    return;
  }

  update();

  background(0);
  player.render();

  for (Astroid astroid : astroids) {
    astroid.render();
  }

  // draw the bullets
  for (Bullet bullet : bullets) {
    bullet.render();
  }

  drawHUD();
}

void drawHUD() {
  textSize(24);
  text("Health", 50, 68);

  stroke(255);
  fill(0);
  rect(125, 50, 200, 20);

  fill(255);
  rect(125, 50, 200 * player.getHealth() / player.getMaxHealth(), 20);
}

void drawMenu() {
}

void drawPauseMenu() {
  fill(255, 0, 0, 128);
  rect(0, 0, width, height);
  fill(255);

  textSize(128);
  textAlign(CENTER);
  text("Give Me\nS P A C E!", width/2, height/2);
  textAlign(LEFT);
}

void drawGameOverMenu() {
  fill(255, 0, 0, 128);
  rect(0, 0, width, height);
  fill(255);

  textSize(128);
  textAlign(CENTER);
  text("Game Over!", width/2, height/2);
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
      print("hit! Health: ");
      println(player.getHealth());
      astroidToRemove.add(astroids.get(i));
    }

    // astroid without health should be removed

    if (astroid.health <= 0) {
      astroidToRemove.add(astroids.get(i));
    }

    // should be removed if off screen
    if (astroidPosition.y < -250 || astroidPosition.x > height + 250 || astroidPosition.y < -250 || astroidPosition.x > height + 250) {
      astroidToRemove.add(astroids.get(i));
    }
  }

  // remove the marked astroids
  astroids.removeAll(astroidToRemove);

  if (player.getHealth() <= 0) {
    state = GameState.GAME_OVER;
    resetGame();
  }
}


void generateAstroid() {

  int astroidCountMax = 100;

  if (astroids.size() > astroidCountMax) {
    return;
  }

  int health = int(random(level, 3 + level));

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

  float size = random(10 + level * 10, 10 + level * 20);

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
    state = (state == GameState.RUNNING) ? GameState.PAUSED : GameState.RUNNING;
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
  level = 1;

  SpaceShip player;
  astroids = new ArrayList();
  bullets = new ArrayList();

  player = new SpaceShip(100, 100, 100, 100, 1000, new PVector(width/2, height / 2));

  GameState state = GameState.IN_MENU;
}
