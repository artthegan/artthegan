class shot {
  float xCord;
  float yCord;
  float Size;
  
  shot (float x, float y, float size) {
    xCord = x;
    yCord = y;
    Size = size;
  }
  
  void display() {
    ellipseMode(CENTER);
    ellipse(xCord, yCord, Size, Size);
  }
  
  void begin(float speed, int xDirection, int yDirection) {
    if (xCord < width && xCord > 0 && yCord < height && yCord > 0) {
     xCord = xCord + speed * xDirection;
     yCord = yCord + speed * yDirection;
    }
  }
  
  float xCord() {
    return xCord;
  }
  
  float yCord() {
    return yCord;
  }
}