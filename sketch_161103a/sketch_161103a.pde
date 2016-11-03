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
    ellipse(xCord, yCord, Size, Size);
  }
  
  void shoot(float speed, int xDirection, int yDirection) {
     xCord = speed * (xDirection);
     yCord = speed * (yDirection);
  }
}