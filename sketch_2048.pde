Board board;
int wantedNum=512;
float start = millis();
void setup() {
board = new Board();
size(500, 550); //size(len, len);
textFont(createFont("Courier", 40));
////////////////////////////////////////


randomBoard();






}

void draw()
{
}

void mouseClicked()
{
  
   //rect(121,500,120,35,5);
   if(mouseX>120&&mouseX<121+121&&mouseY>499&&mouseY<500+35)
   {
     println("Restart");
     randomBoard();
   }
}

void randomBoard()
{
  
  /*while(!board.gameover()){
  
    board.minMaxMove();
  }*/
board=new Board();
  
start = millis();
  while(true){

  if(board.maxNum()<wantedNum)
  {
    board = new Board();
    while(!board.gameover()){
  
    board.future();
  }

//println("Max num in board: " + board.maxNum());

  println("Max num in board: " + board.maxNum());


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
println(" seconds.");

}







