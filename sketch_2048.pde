Board board;
void setup() {
board = new Board();
size(500, 500); //size(len, len);
textFont(createFont("Courier", 40));
////////////////////////////////////////
while(!board.gameover()){
  if (board.ableToMoveRight()){
    println(board.right());
  }
  if (board.ableToMoveDown()){
    println(board.down());
  }
  if(!board.ableToMoveRight() && !board.ableToMoveDown()){
    if (board.ableToMoveLeft()){
      println(board.left());
    }
  }


}
}
void loop(){
  
}

