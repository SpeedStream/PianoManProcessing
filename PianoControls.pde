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
