public class Board{
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
  public boolean ableToMoveDown(){
 int[][] newb = go(1, 0, true);
    if (newb != null) {
      return true;
    }
      return false;
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

public void spawn() {
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

void minMaxMove(){
  int right = 0, left = 0, up = 0, down = 0;
if (board.ableToMoveRight()){
  right = board.amountOfZeroes(board.getRight());
}
if (board.ableToMoveLeft()){
  left = board.amountOfZeroes(board.getLeft());
}
if (board.ableToMoveUp()){
  up = board.amountOfZeroes(board.getUp());
}
if (board.ableToMoveDown()){
  down = board.amountOfZeroes(board.getDown());
}
if (Math.max(Math.max(right, left),Math.max(up, down)) == right &&
      Math.max(Math.max(right, left),Math.max(up, down)) == up){
      if ((Math.random() < 0.5)){
        board.right();
        println("right");
        return;  
      }else{
        board.up();
        println("up");
        return;
      }

}
if(Math.max(Math.max(right, left),Math.max(up, down)) == right){
  board.right();
  println("right");
  return;
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == left){
  board.left();
  println("left");
  return;
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == up){
  board.up();
  println("up");
  return;
}
if(Math.max(Math.max(right, left),Math.max(up, down)) == down){
  board.down();
  println("down");
  return;
}
}
}
