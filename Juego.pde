/*void GenerateSequence(){
  secuencia = new ArrayList<Tecla>();
  flashSequence = new ArrayList<Tecla>();
  currentSequence = new ArrayList<Tecla>();
  print("Sequence : ");
  for(int i = 0; i <= 1; i++){
    int index = (int)random(8);
    secuencia.add(teclas.get(index));
    flashSequence.add(teclas.get(index));
    currentSequence.add(teclas.get(index));
    print(index + 1 + " - ");
  }
}
*/

void evaluateUsrInput(int PVal, int UVal){
  if (UVal != 0) {
    println("UsrPreseed"); 
    if(PVal == UVal){
      println("Correct tile");
      ShowTile(UVal);
      setStars(+1);  //+1 estrella
      usrTurn = false;
    }
    else{
      println("Wrong tile");
      setStars(-1);  //-1 estrella 
    }
  }
}

int GenerateValue(){
  int genVal =(int)random(1,5); 
  println("Juego.GenerateValue.genVal -> " + genVal); 
  return genVal;
}
