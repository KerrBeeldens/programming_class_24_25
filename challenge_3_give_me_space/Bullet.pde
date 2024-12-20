public class Bullet {
 
  private PVector position;
  private PVector velocity;
  
  private float hitboxSize;
  
  public Bullet (PVector position, PVector velocity, float hitboxSize) {
   this.position = position;
   this.velocity = velocity;
   this.hitboxSize = hitboxSize;
  }
  
  public void render() {
    circle(position.x, position.y, hitboxSize);
  }
  
  public void update() {
    position.add(velocity);
  }
  
  public PVector getPosition() { return position; }
  public float getHitboxSize() { return hitboxSize; }
}
