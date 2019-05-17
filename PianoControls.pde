void setPort(Integer portNum) {
  try {
    println("Trying port: " + portNum);
    myPort = new Serial(this, Serial.list()[portNum], 9600);
    println("CONTACT! PortName -> " + myPort);
    myPort.write("M");    
    firstContact = true;
  }
  catch(Exception e) {
    if (mPortNum <= Serial.list().length) {
      mPortNum = mPortNum + 1;
      setPort(mPortNum);
      serialEvent(myPort);
    } else {
      mPortNum = 0;
      setPort(mPortNum);
    }
  }
}

void serialEvent(Serial thePort) {
  val = thePort.readStringUntil('\n');
  if ((val != null) && (usrTurn == true)) {
    UsrVal = 0;
    val = trim(val);
    if (firstContact == true) {
      switch(val) {
      case "O":
        UsrVal = 1;
        break;
      case "B":
        UsrVal = 2;
        break;
      case "Y":
        UsrVal = 3;
        break;
      case "G":
        UsrVal = 4;
        break;
      }
      usrTurn = false;
      println("PianoControls.serialEvent.UsrVal -> " + UsrVal);
      evaluateUsrInput(PcVal, UsrVal);
    }
  }
}

void mousePressed(){
  if((mouseX > 121 && mouseX <  121 + tileWidth) && (mouseY > 306 && mouseY < tileHeight)){
    evaluateUsrInput(PcVal, 1);
  }
  if((mouseX > 421 && mouseX <  421 + tileWidth) && (mouseY > 306 && mouseY < tileHeight)){
    evaluateUsrInput(PcVal, 2);
  }
  if((mouseX > 703 && mouseX <  703 + tileWidth) && (mouseY > 306 && mouseY < tileHeight)){
    evaluateUsrInput(PcVal, 3);
  }
  if((mouseX > 994 && mouseX <  994 + tileWidth) && (mouseY > 306 && mouseY < tileHeight)){
    evaluateUsrInput(PcVal, 4);
  }
}
