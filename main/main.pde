Man Jacob = new Man(30,30,50,50);
Man Aggi = new Man(30,30,450,450);

void setup() {
  size(500, 500);
  
}

<<<<<<< Updated upstream
void draw() {
=======
void draw(){
  background(100,77,33);
  Jacob.display();
  Jacob.movement('w','s','a','d', 3);
>>>>>>> Stashed changes
  
  Aggi.display();
  Aggi.movementarrows(3);
}