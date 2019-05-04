class Rectangle{
  public PVector position;
  int c;
  boolean isFlashed = false;
  color tileColor;
  boolean mVisible;
  SoundFile sound;
  
  public void flash(){
    isFlashed = true;
  }

  public void update(){
    if (isFlashed){
      tileColor = lerpColor(tilesOff[c], tilesOn[c], 1000 * 1.0f);
      sound.play();
      delay(1000);
      isFlashed = false;
    }
    else{
      tileColor = tilesOff[c];      
    }
  }
}

class Tecla extends Rectangle{
  void pressed(){
    flash();
  }
}
