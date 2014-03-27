Board board;
int wantedNum=1024;
void setup() {
board = new Board();
size(500, 550); //size(len, len);
textFont(createFont("Courier", 40));
////////////////////////////////////////
<<<<<<< HEAD
int start = millis();
=======

>>>>>>> FETCH_HEAD
while(!board.gameover()){
  
  board.minMaxMove();
}
<<<<<<< HEAD

=======
int start = millis();
>>>>>>> FETCH_HEAD
while(true){

if(board.maxNum()<wantedNum)
{
  board = new Board();
  while(!board.gameover()){
  
  board.future();
}
<<<<<<< HEAD
//println("Max num in board: " + board.maxNum());
=======
println("Max num in board: " + board.maxNum());
>>>>>>> FETCH_HEAD
}
else
{
  break;
}
}
println("Eureka!!");
//board.minMaxMove();
//board.minMaxMove();
//board.minMaxMove();
print("took ");
print((millis()-start)/1000);
print(" seconds.");
<<<<<<< HEAD




}

=======




}
>>>>>>> FETCH_HEAD
