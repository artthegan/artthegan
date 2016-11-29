import ddf.minim.*;
Minim minim;
AudioPlayer player;

Game game = new Game(2, 3);

Man Jacob = new Man(30, 50, 250);
Man Aggi = new Man(30, 450, 250);

void setup() {
  size(500, 500);
}

void draw(){
  background(100,1,33);
  
  minim = new Minim(this);
  player = minim.loadFile("http://soundimage.org/wp-content/uploads/2014/04/Game-Menu.mp3");
  
  game.score(1, 15);
  //game.Trigger('x', Jacob, Aggi, 2);
  
  Jacob.display();
  Jacob.movement('w','s','a','d', 3);
  
  Aggi.display();
  Aggi.movementarrows(3);
}