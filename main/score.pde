class Game {
  
  Game (int players, int lifes) {
    
    //create all players
    int[] player = new int[players - 1];
    
    //gives each player their starting lifes
    for (int playerNumber = 0; playerNumber <= players; playerNumber++) {         
      player[playerNumber] = lifes;
    }
    
  }
  
  void lifes(int playerNumber) {
    player[playerNumber - 1]--;
  }
  
  void collision(float playerSize, float xCordPlayer, float yCordPlayer, float bulletSize, float xCordBullet, float yCordBullet) {
    //detects if distance between player and bullet centrum is less than or equal to their sizes added.
    if (dist(xCordPlayer, yCordPlayer, xCordBullet, yCordBullet) <= (playerSize + bulletSize)) {
      return true;
    } 
  }
  
  void gameOver() {
    for (int playerNumber = 0; playerNumber <= players; i++) {         
      if (player[playerNumber] <= 0) {
        return true;
      }
    }
  }
  
  void display (float xCord, float yCord) {
    char display;
    char playerNum;
    char lifes;
    for (int playerNumber = 0; playerNumber <= players; i++) { 
      playerNum = char(playerNumber + 1);
      lifes = char(player[playerNumber]);
      display += "Player " + playerNum + ": " + lifes + " lifes ";
    }
    text(display, xCord, yCord);
  }
}