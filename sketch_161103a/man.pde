// Krav til manden
// kan gå frit, op, ned, til side og man skal selv kunne bestemme hvilke taster man vil bruge.
// Der er skal være to mænd 
// 


class man {
float sizeWidth;
float sizeHeight;
float xCord;
float yCord;

  man (float Width, float Height, float x, float y) {
  sizeWidth = Width;
  sizeHeight = Height; 
  xCord = x;
  yCord = y;
  
}

rect(xCord, yCord, sizeWidth, sizeHeight);


}