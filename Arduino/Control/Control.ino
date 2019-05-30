/*
 * Aarón E. Santos
 * 30/05/2019
 * Versión para handshake con processing
*/

#define   LED_Red  2
#define   LED_Blue    4
#define   LED_Yellow  3
#define   LED_Green   5
#define   PRESSURE    100
#define   BUTTONDELAY 250

const int sensor1 = A3;
const int sensor2 = A1;
const int sensor3 = A2;
const int sensor4 = A0;

int pad_Red = 0;
int pad_Blue = 0;
int pad_Yellow = 0;
int pad_Green = 0;
int i = 10000;
bool handshake = false;
bool contact = false;

void setup() {
  // put your setup code here, to run once:
  pinMode(13, OUTPUT);
  Serial.begin(9600);

  pinMode(pad_Red, INPUT);
  pinMode(pad_Blue, INPUT);
  pinMode(pad_Yellow, INPUT);
  pinMode(pad_Green, INPUT);

  pinMode(LED_Red, OUTPUT);// Configuramos los pines de los leds y del zumbador como salidas
  pinMode(LED_Blue, OUTPUT);//en 2,3,4,5
  pinMode(LED_Yellow, OUTPUT);
  pinMode(LED_Green, OUTPUT);
  setAllLedsOff();
  doHandshake();
}

void loop() {
  //if(contact){
    UserInput();
  /*}
  else{
    doHandshake();
  }*/
}

void doHandshake(){
  while(!contact){
    //Serial.println("doHandshake.while.!contact");
    digitalWrite(LED_Red, HIGH);
    establishContact();
  }
  digitalWrite(LED_Red, LOW);
  digitalWrite(LED_Green, HIGH);
  digitalWrite(LED_Yellow, HIGH);
  digitalWrite(LED_Blue, HIGH);
  Serial.println('M');
  setAllLedsOff();
}

void establishContact(){
  if((Serial.available() > 0) && (Serial.read() == 'P')){
    Serial.print("Value recieved -> " + Serial.read());
    contact = true;
  }
  /*if(Serial.readString() == 'P'){
    handshake = true;
  }*/
}

void secuenciaInicio() {
  int counter = 0;
  while (counter < 2) {
    digitalWrite(LED_Red, HIGH);
    digitalWrite(LED_Blue, HIGH);
    digitalWrite(LED_Yellow, HIGH);
    digitalWrite(LED_Green, HIGH);
    delay(500);
    setAllLedsOff();
    delay(500);
    counter++;
  }
}

void secuenciaGameOver() {
  digitalWrite(LED_Red, HIGH);
  digitalWrite(LED_Blue, HIGH);
  digitalWrite(LED_Yellow, HIGH);
  digitalWrite(LED_Green, HIGH);
  delay(5000);
  setAllLedsOff();
}

void setLedOn(int ledID, int timedelay) {
  digitalWrite(ledID, HIGH);
  delay(timedelay);
  digitalWrite(ledID, LOW);
}

void setAllLedsOn(){
  digitalWrite(LED_Red, HIGH);
  digitalWrite(LED_Blue, HIGH);
  digitalWrite(LED_Yellow, HIGH);
  digitalWrite(LED_Green, HIGH);
}

void setAllLedsOff() {
  digitalWrite(LED_Red, LOW);
  digitalWrite(LED_Blue, LOW);
  digitalWrite(LED_Yellow, LOW);
  digitalWrite(LED_Green, LOW);
}

void UserInput() {
  /*
     Pad presionado -> Enciende LED correspondiente
     Mostrar en consola el valor presionado
  */
  pad_Red  = analogRead(sensor1);
  pad_Blue    = analogRead(sensor2);
  pad_Yellow  = analogRead(sensor3);
  pad_Green   = analogRead(sensor4);

  if (pad_Red > PRESSURE) {
    Serial.println("O");
    setLedOn(LED_Red, BUTTONDELAY);
  }
  if (pad_Blue > PRESSURE) {
    Serial.println("B");
    setLedOn(LED_Blue, BUTTONDELAY);
  }
  if (pad_Yellow > PRESSURE) {
    Serial.println("Y");
    setLedOn(LED_Yellow, BUTTONDELAY);
  }
  if (pad_Green > PRESSURE) {
    Serial.println("G");
    setLedOn(LED_Green, BUTTONDELAY);
  }
}
