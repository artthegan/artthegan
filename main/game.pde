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
  
  void Trigger(char button, Man man, Man target, int targetNumber) {
    ArrayList<Shot> shots = new ArrayList<Shot>();
    if (keyPressed && key == button) {
      for (int shotNumber = 0; ; shotNumber++) { 
        shots.add(new Shot(man, 10));
        Shot bullet = shots.get(shotNumber);
        bullet.begin(3, man);
      }
    }
    for (int shotNumber = 0; ; shotNumber++) { 
        //max to 10 shots at a time
        shotNumber = shotNumber % 10;
        shots.add(shotNumber, new Shot(man, 10));
        shots.get(shotNumber).begin(3, man);
        game.collision(target, targetNumber, shots.get(shotNumber));
    }
  }
  
}