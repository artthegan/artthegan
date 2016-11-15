Game game = new Game(2, 3);
Shot bullet = new Shot(250, 250, 10);

void setup() {
  size(500, 500);
}

void draw() {
  background(10, 20, 10);
  
  game.score(100, 100);
  bullet.display();
  bullet.begin(5, 1, 0);
  game.collision(10, 450, 250, 1, bullet);
}