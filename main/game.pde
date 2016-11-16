class Game {
  int[] player;
  
  //max 4 players
  Game (int playerNum, int lifes) {
    
    //create all players
    player = new int[playerNum];
    
    //gives each player their starting lifes
    for (int playerNumber = 0; playerNumber < player.length; playerNumber++) { 
      player[playerNumber] = lifes;
    }
  }
  
  void collision(Man man, int playerNumber, Shot bullet) {
    //detects if distance between player and bullet centrum is less than or equal to their sizes added.
    if (dist(man.xCord, man.yCord, bullet.xCord, bullet.yCord) <= (man.size + bullet.Size)) {
      player[playerNumber - 1]--;
      bullet.end();
    }
  }
  
  boolean gameOver() {
    boolean res = false;
    for (int playerNumber = 0; playerNumber < player.length; playerNumber++) { 
      if (player[playerNumber] <= 0) {
         res = true;
      }
    }    
    return res;
  }
  
  void score (float xCord, float yCord) {
    String[] display = new String[player.length];
    String text;
    String playerNum;
    String lifes;
    
    for (int playerNumber = 0; playerNumber < player.length; playerNumber++) { 
      playerNum = str(playerNumber + 1);
      lifes = str(player[playerNumber]);
      
      display[playerNumber] = "Player " + playerNum + ": " + lifes + " lifes ";
    }
    text = join(display, " | ");
    text(text, xCord, yCord);
  }
  
  void gun(Man man) {
    
    
  }
}