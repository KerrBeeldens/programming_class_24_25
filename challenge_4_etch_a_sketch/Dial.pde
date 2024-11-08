public class Dial {
    
    private float angle;
    private float previousAngle;
    private boolean isActive = false;
    private boolean isEnabled = true;
    
    private PVector position;
    private int radius;
    
    private int minimumValue;
    private int maximumValue;
    
    private float sensitivity;
    private float value;
    
    Dial(PVector position, int radius, int minimumValue, int maximumValue, float sensitivity) {
        this.position = position;
        this.radius = radius;
        this.minimumValue = minimumValue;
        this.maximumValue = maximumValue;
        this.sensitivity = sensitivity;
    }
    
    public void render() {
        fill(255);
        stroke(0);
        circle(position.x, position.y, radius * 2);
        
        noStroke();
        fill(0);
        circle(position.x + 0.75f * radius * cos(angle), position.y + 0.8f * radius * sin(angle), 10);
    }
    
    public void onMousePressed(PVector position) {
        isActive = this.position.dist(position) <= radius;
        isEnabled = true;
        previousAngle = atan2(this.position.y - position.y, this.position.x - position.x);
    }
    
    public void onMouseDragged(PVector position) {
        if (isActive && isEnabled) {
            float currentAngle = atan2(this.position.y - position.y, this.position.x - position.x);
            float angleDelta = currentAngle - previousAngle;

            if (angleDelta > PI) {
                angleDelta -= TWO_PI;
            } else if (angleDelta < -PI) {
                angleDelta += TWO_PI;
            }
            
            float newAngle = angle + angleDelta;
            float newValue = newAngle / PI * sensitivity;
            
            boolean isInBounds = newValue >= minimumValue && newValue <= maximumValue;
            
            if (isInBounds) {
                angle = newAngle;
                previousAngle = currentAngle;
                this.value = newValue;
            } else {
              // The dial should stop moving until it is released and clicked on again
              isEnabled = false;
            }
        }
    }

    public float getValue() {
        return value;
    }
}
