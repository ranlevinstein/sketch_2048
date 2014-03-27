Board board;
void setup() {
board = new Board();
size(500, 500); //size(len, len);
textFont(createFont("Courier", 40));
////////////////////////////////////////
}

void draw() {
  
  board.minMaxMove();
  int now = millis();
  while((millis()- now) < 15){}
  if(board.gameover()){
  println("lost");
  while(true){}
  }
}
