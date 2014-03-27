Board board;
void setup() {
board = new Board();
size(500, 500); //size(len, len);
textFont(createFont("Courier", 40));
////////////////////////////////////////
while(!board.gameover()){
  board.minMaxMove();
}
//board.minMaxMove();
//board.minMaxMove();
//board.minMaxMove();

}


