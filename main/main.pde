Game game = new Game(2, 3);
Man Jacob = new Man(30, 50, 250);
Man Aggi = new Man(30, 450, 250);
Shot bullet;

void setup() {
  size(500, 500);
  bullet = new Shot(Jacob, 10);
}

void draw(){
  background(100,77,33);
  
  bullet.begin(3, 1, 0);
  bullet.display();
  
  game.collision(Aggi, 2, bullet);
  game.score(1, 10);
  
  Jacob.display();
  Jacob.movement('w','s','a','d', 3);
  
  Aggi.display();
  Aggi.movementarrows(3);
}