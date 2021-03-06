public class Board{
 // PVector x = new PVector();
 int kSideRank=20;//If you want major number on side more to have more power on ranking system make this higher
 int kAddableRank=45;
 int kSumOfAddables = 30;
  protected int[][] b = new int[4][4];
  protected int pad = 20, bs = 100, len = pad*(b.length+1)+bs*b.length, score = 0, dead = 1;
  Board(){
    registerDraw(this);

    restart();
    spawn();
 } 
 Board(int[][] board){
   restart();
   b = board;
    registerDraw(this);

 } 
 
 public int[][] getBoard(){
  return b; 
 }
 
 public int maxNum()
 {
   int max = 0;
   for(int i=0;i<b.length;i++)
   {
     for(int n=0;n<b.length;n++)
     {
       if(b[i][n]>max)
       {
         max=b[i][n];
       }
     }
   }
   return max;
 }
 
  public boolean ableToMoveDown(){
   int[][] newb = go(1, 0, true);
    if (newb != null) {
      return true;
    }
      return false;
  }
  
  public int addable(int [][] a){ //Returns how many addable places are in the array

    int amount = 0;
    int sum = 0;
 
    for(int i=1;i<a.length;i++)
    {
     
     for(int j=1;j<a.length;j++)
     {
       
         if((a[i][j]==a[i][j-1] && a[i][j] != 0) || (a[i][j]==a[i-1][j] && a[i][j] != 0) || (a[i-1][j]==a[i-1][j-1] && a[i-1][j]!=0) || (a[i][j-1]==a[i-1][j-1] && a[i][j-1]!=0) ){
             amount++;
             sum+=a[i][j];
         }
       }
     }
     
     //Return part of the ranking for the ranking system (with addable and sum constants)
     return amount*kAddableRank+sum*kSumOfAddables;
    }
  

  
  
  
  public PVector majorNumLoc(int c[][])
  {
    //int max = 0;
    PVector vector = new PVector(0,0);
   for(int i=0;i<c.length;i++)
   {
     for(int n=0;n<c.length;n++)
     {
       if(c[i][n]>c[(int)vector.x][(int)vector.y])
       {
         vector.x = i;
         vector.y = n;
         
       }
     }
   }
   return vector;
  }
  
  
  public int isMajorOnSide(int i[][])
  {
    PVector vector = majorNumLoc(i);
    
    if((vector.x==0&&vector.y==0)||(vector.x==3&&vector.y==3)||(vector.x==3&&vector.y==0)||(vector.x==0&&vector.y==3))
      return 1;
    else
      return 0;
    //Returning int and not boolean because then easier to perform math calculations on it
  }
  
  
  public boolean down(){
  int[][] newb = go(1, 0, true);
    if (newb != null) {
      b = newb;
      spawn();
      return true;
    }
      return false;
  }
public boolean ableToMoveRight(){
 int[][] newb = go(0, 1, true);
    if (newb != null) {
      return true;
    }
      return false;
}
public int[][] getRight(){
  return go(0, 1, true);
}
public int[][] getLeft(){
  return go(0, -1, true);
}
public int[][] getDown(){
  return go(1, 0, true);
}
public int[][] getUp(){
  return go(-1, 0, true);
}
public boolean right(){
 int[][] newb = go(0, 1, true);
    if (newb != null) {
      b = newb;
      spawn();
      return true;
    }
      return false;
}
public boolean ableToMoveLeft(){
 int[][] newb = go(0, -1, true);
    if (newb != null) {
      return true;
    }
      return false;
}
public boolean left(){
 int[][] newb = go(0, -1, true);
    if (newb != null) {
      b = newb;
      spawn();
      return true;
    }
      return false;
}
public boolean ableToMoveUp(){
 int[][] newb = go(-1, 0, true);
    if (newb != null) {
      return true;
    }
      return false;
}
public boolean up(){
 int[][] newb = go(-1, 0, true);
    if (newb != null) {
      b = newb;
      spawn();
      return true;
    }
      return false;
}

public void spawn() {//Positions a square in the board 
  ArrayList<Integer> xs = new ArrayList<Integer>(), ys = new ArrayList<Integer>();
  for (int j = 0 ; j < b.length; j++) for (int i = 0 ; i < b[j].length; i++) if (b[j][i]==0) {
    xs.add(i);
    ys.add(j);
  }
  int rnd = (int)random(0, xs.size()), y = ys.get(rnd), x = xs.get(rnd);
  b[y][x] = random(0, 1) < .9 ? 2 : 4;
  
}



public boolean gameover() {
  int[] dx = {1, -1, 0, 0}, dy = {0, 0, 1, -1};
  boolean out = true;
  for (int i = 0 ; i < 4; i++) if (go(dy[i], dx[i], false) != null) out = false;
  return out;
}
public int[][] go(int dy, int dx, boolean updatescore) {
  int[][] bak = new int[4][4];
  for (int j = 0 ; j < 4; j++) for (int i = 0 ; i < 4; i++) bak[j][i] = b[j][i];
  boolean moved = false; 
  if (dx != 0 || dy != 0) {
    int d =  dx != 0 ? dx : dy;
    for (int perp = 0; perp < b.length; perp++) 
      for (int tang = (d > 0 ? b.length - 2 : 1); tang != (d > 0 ? -1 : b.length); tang-=d) {
      int y = dx != 0 ? perp : tang, x = dx != 0 ? tang : perp, ty = y, tx = x;
      if (bak[y][x]==0) continue;
      for (int i=(dx != 0 ? x : y)+d; i!= (d > 0 ? b.length : -1); i+=d) {
        int r = dx != 0 ? y : i, c = dx != 0 ? i : x;
        if (bak[r][c] != 0 && bak[r][c] != bak[y][x]) break;
        if (dx != 0) tx = i; 
        else ty = i;
      }
      if ( (dx != 0 && tx == x) || (dy != 0 && ty == y)) continue;
      else if (bak[ty][tx]==bak[y][x]) {
        bak[ty][tx] *= 2;
        if(updatescore) score += bak[ty][tx];
        moved = true;
      }
      else if ( (dx != 0 && tx != x) || (dy != 0 && ty != y)) {
        bak[ty][tx] = bak[y][x];
        moved = true;
      }
      if (moved) bak[y][x] = 0;
    }
  }
  return moved ? bak : null;
}

void draw() {
  background(255);
  noStroke();
  rectt(0,0,width,height,10,color(150));
  for (int j = 0 ; j < b.length; j++) 
    for (int i = 0 ; i < b[j].length; i++) {
      fill(200);
      rect(pad+(pad+bs)*i, pad+(pad+bs)*j, bs, bs, 5);
    }
    
     fill(70);//Buttons to control game
     
rect(121,500,120,35,5);//Random
fill(255);
textSize(20);
text("Random",121+120/2-37,524);
fill(70);

rect(121+120+20,500,120,35,5);//Manual
fill(255);
textSize(20);
text("Manual",121+120+20+120/2-37,524);

    
  for (int j = 0 ; j < b.length; j++) 
    for (int i = 0 ; i < b[j].length; i++) {
      float x = pad+(pad+bs)*i, y=pad+(pad+bs)*j;
      if (b[j][i] > 0) {
        float p = log(b[j][i])/log(2);
        rectt(x, y, bs, bs, 5, color(255-p*255/11, p*255/11, 0));
        textt(""+b[j][i], x, y + 22, bs, bs, color(0), 40, CENTER);
      }
    }
    
  textt("score: "+score,10,5,100,50,color(0),10.0, LEFT);
  if(dead>0) { 
    rectt(0,0,width,height,0,color(255,100)); 
    textt("Gameover! Click to restart", 0,height/2,width,50,color(0),30,CENTER); 
    if(mousePressed) restart(); 
  }
  
}
void rectt(float x, float y, float w, float h, float r, color c) { fill(c); rect(x,y,w,h,r);  }
void textt(String t, float x, float y, float w, float h, color c, float s, int align) {
  fill(c); textAlign(align); textSize(s); text(t,x,y,w,h);  }
  
public void restart() {
  b = new int[4][4];
  //spawn();
  score = dead = 0;
}
public int amountOfZeroes(int [][] a){
  int amount = 0;
for (int i = 0; i < a.length; i++){
  for (int j = 0; j < a[i].length; j++){
    if (a[i][j] == 0){
      amount++;
    }
  }
}
return amount;
}

/*public float AverageOfArray(int [][] a){
  int sum = 0;
for (int i = 0; i < a.length; i++){
  for (int j = 0; j < a[i].length; j++){
    if (a[i][j] != 0){
      sum += a[i][j];
    }
  }
}
return (sum/(16-amountOfZeroes(b)));
}*/

void minMaxMove(){

  int right = 0, left = 0, up = 0, down = 0;//This is the ranking system

  
if (ableToMoveRight()){
  //sideRight=isMajorOnSide(getRight());
  right = amountOfZeroes(getRight()) + isMajorOnSide(getRight())*kSideRank + addable(getRight()); //Adding isMajorOnSide as a factor to choose where to go...
}
if (ableToMoveLeft()){
  left = amountOfZeroes(getLeft()) + isMajorOnSide(getLeft())*kSideRank + addable(getLeft());//The constants in addable are now done inside the function ready for the ranking system
}
if (ableToMoveUp()){
  up = amountOfZeroes(getUp()) + isMajorOnSide(getUp())*kSideRank + addable(getUp());
}
if (ableToMoveDown()){
  down = amountOfZeroes(getDown()) + isMajorOnSide(getDown())*kSideRank + addable(getDown());
}

//From here

//To here-------------------------------------------

if(Math.max(Math.max(right, left),Math.max(up, down)) == right){
  right();
  //println("right");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == left){
  left();
  //println("left");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == up){
  up();
  //println("up");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == down){
  down();
  //println("down");
  
}

}


/*
void minMaxSumMove(){
  float right = 0, left = 0, up = 0, down = 0;
if (ableToMoveRight()){
  right = AverageOfArray(getRight());
}
if (ableToMoveLeft()){
  left = AverageOfArray(getLeft());
}
if (ableToMoveUp()){
  up = AverageOfArray(getUp());
}
if (ableToMoveDown()){
  down = AverageOfArray(getDown());
}

if(Math.max(Math.max(right, left),Math.max(up, down)) == right){
  right();
  //println("right");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == left){
  left();
  //println("left");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == up){
  up();
  //println("up");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == down){
  down();
  //println("down");
  
}
}
}
*/





void future(){
Board futureRight = board;
futureRight.right();
Board futureLeft = board;
futureLeft.left();
Board futureUp = board;
futureUp.up();
Board futureDown = board;
futureDown.down();

 for (int i = 0; i < 100; i++){
   futureRight.minMaxMove();
   futureLeft.minMaxMove();
   futureUp.minMaxMove();
   futureDown.minMaxMove();
 }
int right = 0, left = 0, up = 0, down = 0;
  right = amountOfZeroes(futureRight.getBoard());

  //
  
  left = amountOfZeroes(futureLeft.getBoard());

  up = amountOfZeroes(futureUp.getBoard());

  down = amountOfZeroes(futureDown.getBoard());
 if(Math.max(Math.max(right, left),Math.max(up, down)) == right){
   //if(majorNumLoc()
  right();
  //println("right");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == left){
  left();
  //println("left");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == up){
  up();
  //println("up");
  
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == down){
  down();
  //println("down");
  
}
}
}
