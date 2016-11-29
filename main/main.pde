import ddf.minim.*;
Minim minim;
AudioPlayer player;

Game game = new Game(2, 3);

Man Jacob = new Man(30, 50, 250);
Man Aggi = new Man(30, 450, 250);

void setup() {
  size(500, 500);
  
  minim = new Minim(this);
  player = minim.loadFile("sound.mp3");
}

void draw(){
  background(100,1,33);
  
  player.play();
  
  game.score(1, 15);
  //game.Trigger('x', Jacob, Aggi, 2);
  
  Jacob.display();
  Jacob.movement('w','s','a','d', 3);
  
  Aggi.display();
  Aggi.movementarrows(3);
}