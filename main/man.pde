class Man {
  float sizeWidth;
  float sizeHeight;
  float xCord;
  float yCord;
  float size;
  String direction;
  float xDirection;
  float yDirection;
  

  Man (float playerSize, float x, float y) {
    size = playerSize;
    sizeWidth = playerSize;
    sizeHeight = playerSize; 
    xCord = x;
    yCord = y;
    direction = "up";
  }
  
  void display() {
    rectMode(CENTER);
    rect(xCord, yCord, sizeWidth, sizeHeight);
    int miniRectSize = 3;
    if (direction == "up") {
      rectMode(CENTER);
      rect(xCord, (yCord - (size / 2) - miniRectSize), miniRectSize, miniRectSize);
    }
    else if (direction == "down") {
      rectMode(CENTER);
      rect(xCord, (yCord + (size / 2) + miniRectSize), miniRectSize, miniRectSize);
    }
    else if (direction == "left") {
      rectMode(CENTER);
      rect((xCord - (size / 2) - miniRectSize), yCord, miniRectSize, miniRectSize);
    }
    else if (direction == "right") {
      rectMode(CENTER);
      rect((xCord + (size / 2) + miniRectSize), yCord, miniRectSize, miniRectSize);
    }
  }
   
  void movement(char up, char down, char left, char right, int speed) {
    
    if(keyPressed) {
      if (key == up) {
        yCord -= speed;
        direction = "up";
      } else if (key == down) {
        yCord += speed;
        direction = "down";
      }
      if (key == left) {
        xCord -= speed;
        direction = "left";
      } else if (key == right) {
        xCord += speed;
        direction = "right";
      }
    }
  }
  
    void movementarrows(int speed) {
    if(keyPressed) {
      if (keyCode == UP) {
        yCord -= speed;
        direction = "up";
      } else if (keyCode == DOWN) {
        yCord += speed;
        direction = "down";
      }
      if (keyCode == LEFT) {
        xCord -= speed;
        direction = "left";
      } else if (keyCode == RIGHT) {
        xCord += speed;
        direction = "right";
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
  int xDirection() {
    if (direction == "up") {
      return 0;
    }
    else if (direction == "down") {
      return 0;
    }
    else if (direction == "right") {
      return 1;
    }
    else if (direction == "left") {
      return -1;
    }
    return 0;
  }
  int yDirection() {
    if (direction == "up") {
      return -1;
    }
    else if (direction == "down") {
      return 1;
    }
    else if (direction == "right") {
      return 0;
    }
    else if (direction == "left") {
      return 0;
    }
    return 0;
  }
}