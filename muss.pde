import processing.sound.*;
import processing.serial.*; //import the Serial library

Serial myPort;  //the Serial port object
String val;
Integer UsrVal, PcVal;
Integer mPortNum = 0;
boolean firstContact, usrTurn, GameOver, nextTile, tileVisible;
PImage bg, clave;
float tileWidth, tileHeight;
float padding = 41;
float timer, mTimer;
color[] tilesOff;
color[] tilesOn;
SoundFile[] tilesSound;
ArrayList<Tecla> teclas;
ArrayList<Tecla> secuencia;
ArrayList<Tecla> currentSequence;
ArrayList<Tecla> flashSequence;
ArrayList<Star> stars;

Tecla currentFlashed;
Tecla selectedTile = null;
int numTiles = 4;
final int startSequenceLenght = 0;
int currentSequenceLenght = startSequenceLenght;
int starsOn, currentLevel;

void setup(){
  setPort(mPortNum);
  
  size(displayWidth, displayHeight);
  bg = loadImage("resources/imgs/background.jpg");
  bg.resize(displayWidth, displayHeight);
  
  teclas = new ArrayList<Tecla>();
  stars = new ArrayList<Star>();
  tilesOff = new color[] {color(100, 0, 0, 255), color(0, 0, 100, 255), color(100, 100, 0, 255), color(0, 100, 0, 255)};  //R, B, Y, G
  tilesOn = new color[] {color(255, 0, 0, 255), color(0, 0, 255, 255), color(255, 255, 0, 255), color(0, 255, 0, 255)};   //R, B, Y, G
  tilesSound = new SoundFile[] {new SoundFile(this, "resources/audio/do.wav"), new SoundFile(this, "resources/audio/mi.wav"), new SoundFile(this, "resources/audio/si.wav"), new SoundFile(this, "resources/audio/sol.wav")};
  starsOn = 0;
  firstContact = true;
  usrTurn = false;
  GameOver = false;
  tileVisible = false;
    
  mTimer = 2.5f;
  timer = mTimer;
  tileWidth = 250;
  tileHeight = displayHeight + 306;
  //drawBackground();
  CreateTiles();
  GenerateValue();
}

void draw(){
  //if(usrTurn == false){
    drawBackground();
    //println("PCturn");
    //PcVal = GenerateValue();
    ShowTile(PcVal);
    //usrTurn = true;
  //}
  //Wait userTurn -> PianoControls.serialEvent.evaluateUsrInput
  
  /*
  else{
    if (UsrVal != 0) {
      println("UsrPreseed");
      boolean cv = CompareValues(PcVal, UsrVal); 
      if(cv){
        println("Usr correcto");
        ShowTile(UsrVal);
        usrTurn = false;
      }
      else{
        println("Wrong tile");
        setDownStar(); //Disminuye estrella
        println("Starts -> " + starsOn);
        delay(3000);
      }
      //borrar teclado
    }
    
  }
  */
}

void drawSheetMusic(){
  clave = loadImage("resources/imgs/key.png");
  image(clave, 66, 38);
  //Draw sheet music
  strokeWeight(4);
  stroke(2);
  line(100, 50, width-100, 50);
  line(100, 90, width-100, 90);
  line(100, 130, width-100, 130);
  line(100, 170, width-100, 170);
  line(100, 210, width-100, 210);
  strokeWeight(15);
  line(100, 54, 100, 206);
  line(width-100, 54, width-100, 206);
} 

void CreateTiles(){
  teclas = new ArrayList<Tecla>();
  println("Creating tiles");
  for (int y = 0; y < numTiles; y++){
    Tecla t = new Tecla();
    t.c = GetColorIndex(y);
    t.tileColor = tilesOff[t.c];
    t.sound = tilesSound[y];
    t.position = new PVector((80 + (padding * (1 + y))) + (y * tileWidth), 306);
    teclas.add(t);
  }
}

void CreateStars(){
  stars = new ArrayList<Star>();
  //println("Creating stars");
  for (int y=0; y < 5; y++){
    Star s = new Star();
    if(y < starsOn){
      s.setOn(true);
    }
    int yval = 0;
    switch(y%3){
      case 0:
        yval = 100;
        break;
      case 1:
        yval = 130;
        break;
      case 2: 
        yval = 160;
        break;
    }
    s.display((width-300)/5 * (y+1) + 100, yval);
    stars.add(s);
  }
}

void ShowTile(int tile){
  Tecla t = teclas.get(tile-1);
  if(usrTurn == false){
    t.flash();
    usrTurn = true;
  }
  DrawTile(t);
}

int GetColorIndex(int index){ 
  return index % tilesOff.length;
}

void DrawTile(Tecla t){
  if(tileVisible){
    noStroke();
    t.update();
    fill(t.tileColor);
    rect(t.position.x, t.position.y, tileWidth, tileHeight);
  }
  else{
      timer();
  }
}

void setStars(int value){
  if(starsOn >= 0){
    stars.clear();
    starsOn += value;
    if(starsOn >= 5){
      starsOn = 5;
    }
    if(starsOn <= 0){
      starsOn = 0;
    }
    CreateStars();
  }
}

void drawBackground(){
  //println("Redibujando fondo");
  background(bg);
  drawSheetMusic();
  CreateStars();
}

void timer(){
  if(timer >= 0){
    timer -= 0.125f;
  }
  else{
    tileVisible = true;
    timer = mTimer;
  }
}
