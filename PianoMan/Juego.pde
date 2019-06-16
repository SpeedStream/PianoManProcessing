void evaluateUsrInput(int PVal, int UVal){
  if (UVal != 0) { 
    if(PVal == UVal){
      println("Correct tile");
      usrTurn = false;
      ShowTile(UVal);
      setFigures(+1);  //+1 estrella
      GenerateValue();
    }
    /*else{
      println("Wrong tile");
      setFigures(-1);  //-1 estrella 
    }
    GenerateValue();
    */
  }
}

void GenerateValue(){
  tileVisible = false;
  usrTurn = false;
  PcVal = (int)random(1,5);
  println("Juego.GenerateValue.genVal -> " + PcVal);
}
