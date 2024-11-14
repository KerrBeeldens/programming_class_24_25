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
    stroke(200);
    strokeWeight(4);
    fill(255);
    circle(position.x, position.y, radius * 2);
    fill(200);

    for (int i = 0; i < 24; i++) {
      arc(position.x + 0.95 * radius * cos(TWO_PI / 24 * i + angle), position.y + 0.95 * radius * sin(TWO_PI / 24 * i + angle), 10, 10, TWO_PI / 24 * i - QUARTER_PI + angle, TWO_PI / 24 * i + QUARTER_PI + angle);
    }

    line(position.x + 0.5 * radius * cos(angle), position.y + 0.5 * radius * sin(angle), position.x + 0.95 * radius * cos(angle), position.y + 0.95 * radius * sin(angle));
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
