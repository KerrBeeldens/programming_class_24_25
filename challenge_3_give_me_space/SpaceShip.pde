public class SpaceShip { //<>//
  private int health;
  private int maxHealth;

  private float fuel;
  private float maxFuel;

  private int ammo;

  private PVector position;
  private float  speed;

  private float rotation;
  private float angularSpeed;
  private float hitboxSize;


  private IFireRate gun = new SingleFire();

  public SpaceShip(int health, int maxHealth, float fuel, float maxFuel, int ammo, PVector position) {
    this.health = health;
    this.maxHealth = maxHealth;
    this.fuel = fuel;
    this.maxFuel = maxFuel;
    this.ammo = ammo;
    this.position = position;

    speed = 0;
    rotation = 0;
    angularSpeed = 0;
    hitboxSize = 50;
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

    // update the fuel
    if (fuel > 0) {
      fuel -= 0.01 * abs(speed);
    }
  }

  public void render() {
    circle(position.x, position.y, hitboxSize);
    triangle(position.x - 10, position.y, position.x + 10, position.y, position.x + 40 * cos(rotation), position.y + 40 * sin(rotation));
  }

  public void addSpeed(float speed) {
    if (fuel > 0) {
      this.speed += speed;
    }
  }

  public void setAngularSpeed(float angularSpeed) {
    this.angularSpeed = radians(angularSpeed);
  }

  public ArrayList<Bullet> fire(PVector mousePosition) {
    
    ArrayList<Bullet> bullets = new ArrayList();

    if (ammo <= 0) {
      return bullets;
    }

    ammo -= 1;

    // The bulletDirection was created using chatGPT
    PVector bulletDirection = PVector.sub(mousePosition, position).normalize().mult(8); // scale it to desired speed

    return gun.fire(position.copy(), bulletDirection);
  }


  public void addAmmo(int amount) {
    this.ammo += amount;
  }

  public void addFuel(float amount) {
    float fuelTotal = this.fuel + amount;
    this.fuel = fuelTotal > maxFuel ? maxFuel : fuelTotal;
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
