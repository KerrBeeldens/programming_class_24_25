public class Astroid {

  private float size;
  private int health;
  private PVector position;
  private PVector  velocity;

  public Astroid(int health, PVector position, PVector velocity, float size) {
    this.health = health;
    this.position = position;
    this.velocity = velocity;
    this.size = size;
  }

  public void render() {
    circle(position.x, position.y, size);
  }

  public void update() {
    position.add(velocity);
  }


  public void removeHealth(int amount) {
    int healthTotal = this.health - amount;
    this.health = healthTotal < 0 ? 0 : healthTotal;
  }

  public PVector getPosition() { return position; }
  public float getSize() { return size; }
}
