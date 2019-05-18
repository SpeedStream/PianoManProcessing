void evaluateUsrInput(int PVal, int UVal){
  if (UVal != 0) { 
    if(PVal == UVal){
      println("Correct tile");
      usrTurn = false;
      ShowTile(UVal);
      setStars(+1);  //+1 estrella
    }
    else{
      println("Wrong tile");
      setStars(-1);  //-1 estrella 
    }
    GenerateValue();
  }
}

void GenerateValue(){
  tileVisible = false;
  usrTurn = false;
  PcVal = (int)random(1,5);
  println("Juego.GenerateValue.genVal -> " + PcVal);
}
