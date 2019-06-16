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
ArrayList<Star> stars;
ArrayList<Moon> moons;

int numTiles = 4;
int FiguresOn, currentLevel;

void setup(){
  //setPort(mPortNum);
  
  size(displayWidth, displayHeight);
  bg = loadImage("resources/imgs/background.jpg");
  bg.resize(displayWidth, displayHeight);
  
  teclas = new ArrayList<Tecla>();
  stars = new ArrayList<Star>();
  moons = new ArrayList<Moon>();
  tilesOff = new color[] {color(100, 0, 0, 255), color(0, 0, 100, 255), color(100, 100, 0, 255), color(0, 100, 0, 255)};  //R, B, Y, G
  tilesOn = new color[] {color(255, 0, 0, 255), color(0, 0, 255, 255), color(255, 255, 0, 255), color(0, 255, 0, 255)};   //R, B, Y, G
  tilesSound = new SoundFile[] {
                new SoundFile(this, "resources/audio/do.wav"),
                new SoundFile(this, "resources/audio/mi.wav"),
                new SoundFile(this, "resources/audio/si.wav"),
                new SoundFile(this, "resources/audio/sol.wav")
              };
  FiguresOn = 0;
  firstContact = true;
  usrTurn = false;
  GameOver = false;
  tileVisible = false;
    
  mTimer = 2.5f;
  timer = mTimer;
  tileWidth = 250;
  tileHeight = displayHeight + 306;
  currentLevel = 0;
  CreateTiles();
  GenerateValue();
}

void draw(){
    drawBackground();
    ShowTile(PcVal);
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
  for (int y=0; y < 5; y++){
    Star s = new Star();
    if(y < FiguresOn){
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

void CreateMoons(){
  moons = new ArrayList<Moon>();
  for (int y=0; y < 5; y++){
    Moon s = new Moon();
    if(y < FiguresOn){
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
    moons.add(s);
  }
}

void DrawFigures(){
  switch(currentLevel){
    case 0:
      CreateStars();
      break;
    case 1:
      CreateMoons();
      break;
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

void setFigures(int value){
  if(FiguresOn >= 0){
    FiguresOn += value;
    if(FiguresOn >= 5){
      currentLevel += 1;
      FiguresOn = 0;
    }
    stars.clear();
    moons.clear();
    if(FiguresOn <= 0){
      FiguresOn = 0;
    }
    DrawFigures();
  }
}

void drawBackground(){
  background(bg);
  drawSheetMusic();
  DrawFigures();
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
