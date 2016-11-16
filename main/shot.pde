class Shot {
  float xCord;
  float yCord;
  float Size;
  
  Shot (Man man, float size) {
    xCord = man.xCord;
    yCord = man.yCord;
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
  
  void end() {
    xCord = width + Size;
    yCord = height + Size;
  }
  
  float xCord() {
    return xCord;
  }
  
  float yCord() {
    return yCord;
  }
  
  void shoot(float speed, int xDirection, int yDirection){
     xCord = speed * (xDirection);
     yCord = speed * (yDirection);
  }
  
  float Size() {
   return Size;
  }
}