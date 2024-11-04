void setup() {
  // Initialize the window
  size(1920, 1080);
  background(255);
  noStroke();
  fill(int(random(0, 256)), int(random(0, 256)), int(random(0, 256)));
  
  // Initialize the images
  PImage[] images = new PImage[7];
  
  images[0] = loadImage("resources/gradient.png");
  images[1] = loadImage("resources/lenna_128px.png");
  images[2] = loadImage("resources/gradient.png");
  images[3] = loadImage("resources/self_portrait.png");
  images[4] = loadImage("resources/stary_night.png");
  images[5] = loadImage("resources/the_potato_eaters.png");
  images[6] = loadImage("resources/wheat_field_with_cypresses.png");
  
  // Pick a random image
  int randomPick = int(random(0, 7));
  PImage image = images[randomPick];
 
  // Resize the image and load in the pixels
  float imageScale = 0.1;
  
  image.resize(int(image.width * imageScale), int(image.height * imageScale));
  image.loadPixels();
  
  // Calculate the maximum circe diameter (TODO: does not function 100%)
  float circleDiameter;
  
  if (width/height < image.width/image.height) {
    circleDiameter = width/image.width;
  } else {
    circleDiameter = height/image.height;
  }
  
  // convert the image to an halftone
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
     
      // convert the RGB values to a range between 0 and 1
      colorMode(RGB, 1f);
      
      int pixel = image.pixels[y * image.width + x];
      float red = red(pixel);
      float green = green(pixel);
      float blue = blue(pixel);
      
      // Convert RGB to CMYK values (source https://www.rapidtables.com/convert/color/rgb-to-cmyk.html)
      float black = 1 - max(red, green, blue);
      
      // Draw the halftone circles on the screen
      ellipse(x * circleDiameter, y * circleDiameter , circleDiameter * black, circleDiameter * black);
    }
  }
}
