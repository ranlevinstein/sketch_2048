Board board;
int wantedNum=1024;
void setup() {
board = new Board();
size(500, 550); //size(len, len);
textFont(createFont("Courier", 40));
////////////////////////////////////////
int start = millis();
while(!board.gameover()){
  
  board.minMaxMove();
}

while(true){

if(board.maxNum()<wantedNum)
{
  board = new Board();
  while(!board.gameover()){
  
  board.future();
}
//println("Max num in board: " + board.maxNum());
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




}

