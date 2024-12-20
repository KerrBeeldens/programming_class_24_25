public class SingleFire implements IFireRate {
 
  public ArrayList<Bullet> fire(PVector position, PVector velocity) {
   
    ArrayList<Bullet> bullets = new ArrayList();
    bullets.add(new Bullet(position, velocity, 10));
    
    return bullets;
  }
  
}
