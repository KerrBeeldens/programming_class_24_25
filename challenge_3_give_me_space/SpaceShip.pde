public class SpaceShip { //<>//
  private int health;
  private int maxHealth;

  private PVector position;
  private float  speed;

  private float rotation;
  private float angularSpeed;
  private float hitboxSize;

  private IFireRate gun = new SingleFire();

  private PImage[] spaceShipSprite;

  public SpaceShip(int health, int maxHealth, PVector position) {
    this.health = health;
    this.maxHealth = maxHealth;
    this.position = position;

    speed = 0;
    rotation = 0;
    angularSpeed = 0;
    hitboxSize = 50;

    spaceShipSprite =  new PImage[] {loadImage("spaceShip_1.png"), loadImage("spaceShip_2.png"), loadImage("spaceShip_3.png"), loadImage("spaceShip_4.png")};
  }

  public void update() {

    // update the rotation
    rotation += angularSpeed;

    // update speed and position
    this.position.x += speed * cos(rotation);

    if (this.position.x > width) {
      this.position.x = width;
    }

    if (this.position.x < 0) {
      this.position.x = 0;
    }

    this.position.y += speed * sin(rotation);

    if (this.position.y > height) {
      this.position.y = height;
    }

    if (this.position.y < 0) {
      this.position.y = 0;
    }

    speed *= 0.9725; // friction
    angularSpeed *= 0.9; // angular friction
  }

  public void render() {
    imageMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation + HALF_PI);
    image(spaceShipSprite[(maxHealth - 1 - health) / 25], 0, 0, hitboxSize * 1.75, hitboxSize * 1.75);
    popMatrix();
  }

  public void addSpeed(float speed) {
    this.speed += speed;
  }

  public void setAngularSpeed(float angularSpeed) {
    this.angularSpeed = radians(angularSpeed);
  }

  public ArrayList<Bullet> fire(PVector mousePosition) {

    // The bulletDirection was created using chatGPT
    PVector bulletDirection = PVector.sub(mousePosition, position).normalize().mult(8); // scale it to desired speed

    return gun.fire(position.copy(), bulletDirection);
  }

  public void addHealth(int amount) {
    int healthTotal = this.health + amount;
    this.health = healthTotal > maxHealth ? maxHealth : healthTotal;
  }

  public void removeHealth(int amount) {
    int healthTotal = this.health - amount;
    this.health = healthTotal < 0 ? 0 : healthTotal;
  }

  public PVector getPosition() {
    return position;
  }
  public float getHitboxSize() {
    return hitboxSize;
  }
  public int getHealth() {
    return health;
  }

  public int getMaxHealth() {
    return maxHealth;
  }
}
