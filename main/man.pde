// Krav til manden
// kan gå frit, op, ned, til side og man skal selv kunne bestemme 
// - hvilke taster man vil bruge.
// Der er skal være to mænd 



class Man {
  float sizeWidth;
  float sizeHeight;
  float xCord;
  float yCord;
  float size;
  

  Man (float playerSize, float x, float y) {
    size = playerSize;
    sizeWidth = playerSize;
    sizeHeight = playerSize; 
    xCord = x;
    yCord = y;
  }
  
  void display() {
    rect(xCord, yCord, sizeWidth, sizeHeight);
  }
   
  void movement(char up, char down, char left, char right, int speed) {
    
    if(keyPressed) {
      if (key == up) {
        yCord -= speed;
      } else if (key == down) {
        yCord += speed;
      }
      if (key == left) {
        xCord -= speed;
      } else if (key == right) {
        xCord += speed;
      }
    }
  }
  
    void movementarrows(int speed) {
    if(keyPressed) {
      if (keyCode == UP) {
        yCord -= speed;
      } else if (keyCode == DOWN) {
        yCord += speed;  
      }
      if (keyCode == LEFT) {
        xCord -= speed;
      } else if (keyCode == RIGHT) {
        xCord += speed;
      }
    }
  }
  float xCord() {
    return (xCord + (size/2));
  }
  float yCord() {
    return (yCord + (size/2));
  }
  float Size() {
    return size;
  }
}