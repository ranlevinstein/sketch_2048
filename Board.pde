Board board;
int wantedNum=1024;
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
  

board=new Board();
  
start = millis();
  while(board.maxNum()<wantedNum){

 
    board = new Board();
    while(!board.gameover()){
  
    board.minMaxMove();
  }

println("Max num in board: " + board.maxNum());

 



  
 }

println("Eureka!!");

print("took ");
print((millis()-start)/1000);
println(" seconds.");

}
