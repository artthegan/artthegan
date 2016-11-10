shot firstShot = new shot(250, 250, 10);

void setup() {
  size(500, 500);
}

void draw() {
  firstShot.display();
  firstShot.begin(3, -1, 0);
  
}