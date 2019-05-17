class Star {
  PShape star;
  private boolean setOn = false;
  
  Star() {
    star = createShape();
  }
  
  void setOn(boolean _setOn){
    setOn = _setOn;
  }
  
  void display(float dx, float dy) {
    
    star.beginShape();
    if(setOn){
      star.fill(#FFEF3D);
    }
    else{
      star.fill(#B5A1A8);
    }
    star.noStroke();
    star.vertex(0, -50);
    star.vertex(14, -20);
    star.vertex(47, -15);
    star.vertex(23, 7);
    star.vertex(29, 40);
    star.vertex(0, 25);
    star.vertex(-29, 40);
    star.vertex(-23, 7);
    star.vertex(-47, -15);
    star.vertex(-14, -20);
    star.endShape(CLOSE);
    shape(star, dx, dy);
  }
}
