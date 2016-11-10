class Score {
  
  Score (int players, int lifes) {
    
    //create all players
    int[] player = new int[players - 1];
    
    //gives each player their starting lifes
    for (int i = 0; i <= players; i++) {         
      player[i] = lifes;
    }

  }
  
  void lifes() {
    
  }
  
  void collision(float playerSize, float xCordPlayer, float yCordPlayer, float bulletSize, float xCordBullet, float yCordBullet) {
    
  }
  
}