class Rectangle{
  public PVector position;
  int c;
  boolean isFlashed = false;
  boolean isPlaying = false;
  boolean isVisible = false;
  color tileColor;
  boolean mVisible;
  SoundFile sound;
  final private float flashTimePerFrame = 0.125f;
  final private float flashTime = 1.5f;
  private float flashTimer = 0.0f;
  
  public void flash(){
    isFlashed = true;
    isPlaying = true;
    isVisible = true;
    flashTimer = flashTime;
  }
  
  private void playSound(){
    //println(!sound.isPlaying() + " | " + isFlashed + " | " + isPlaying);
    if(!sound.isPlaying() && (isFlashed) && (isPlaying)){
      sound.play();
      isPlaying = false;
    }
  }
  
  public void showOkMessage(){
    textSize(32);
    text("OK!", this.position.x + 50 , this.position.y+50);
  }

  public void update(){
    playSound();
    if (isFlashed && flashTimer > 0){
      tileColor = lerpColor(tilesOff[c], tilesOn[c], flashTimer * 1.0f);
      tileColor = tilesOn[c];
      flashTimer -= flashTimePerFrame;
    }
    else{
      isFlashed = false;
      sound.stop();
      tileColor = tilesOff[c];
    }
  }
}

class Tecla extends Rectangle{
  void pressed(){
    flash();
  }
  
  void correct(){
    showOkMessage();
  }
  
}
