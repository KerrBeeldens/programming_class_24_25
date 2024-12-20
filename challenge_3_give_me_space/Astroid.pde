public class Astroid {

  private float size;
  private int health;
  private PVector position;
  private PVector  velocity;

  private PImage astroidSprite;
  private float spriteRotation = random(0, TWO_PI);

  public Astroid(int health, PVector position, PVector velocity, float size) {
    this.health = health;
    this.position = position;
    this.velocity = velocity;
    this.size = size;

    float randomNumber = random(1);

    if (randomNumber > 0.66) {
      astroidSprite = loadImage("astroid_1.png");
    } else if (randomNumber > 0.33) {
      astroidSprite = loadImage("astroid_2.png");
    } else {
      astroidSprite = loadImage("astroid_3.png");
    }
  }

    public void render() {

      imageMode(CENTER);

      pushMatrix();
      translate(position.x, position.y);
      rotate(spriteRotation);
      image(astroidSprite, 0, 0, size, size);
      popMatrix();
    }

    public void update() {
      position.add(velocity);
    }


    public void removeHealth(int amount) {
      int healthTotal = this.health - amount;
      this.health = healthTotal < 0 ? 0 : healthTotal;
    }

    public PVector getPosition() {
      return position;
    }
    public float getSize() {
      return size;
    }
  }
