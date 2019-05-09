#include <SPI.h>
//#include <pcmConfig.h>
//#include <pcmRF.h>
//#include <TMRpcm.h>
#include <SD.h>
#define pinSD 10    // pin CS arduino UNO 10 / MEGA 53                     
//TMRpcm tmrpcm;

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
char PCValue;
bool handshake = false;

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
}

void loop() {
  /*
   * WARNING: Handshake still in development. DO NOT UNCOMMENT THIS
   * 
   * if(!handshake){
   *  DoHandShake(Serial.read());
   * }
   * else{
   *  ControlMode();
   * }
  */
  ControlMode();
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

void DoHandShake(char value) {
  /*
   * Still in development 
   * Mantener comunicación de handshake PC-Arduino
   * para establecer puerto de conexión.
   * Ciclo de vida:
   *  * PC lee todos los puertos para establecer conexión
   *  * Por cada uno de ellos:
   *  *  * PC conecta al puerto P
   *  *  * PC escribe 'P' al puerto P y espera N intentos
   *  *  * Si PC recibe respuesta 'M'
   *  *  *  * PC mantiene conexión en ese puerto
   *  *  *  * Ard pasa a modo "Control" -> Invoca permanentemente UsrInput()
   *  *  * Else
   *  *  *  * PC pasa a probar con el siguiente puerto disponible
   *  
   * value -> Valor recibido desde la PC (enviado por Processing)
  */
  if(value == 'P'){
    setAllLedsOff();
    Serial.write("M");
    handshake = true;
  }
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

void ControlMode() {
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
