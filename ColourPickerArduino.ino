/*
  Arduino Colour Picker
  Conor Souness
  2016-05-11
*/



const int potin = 0; // anolog input pin connected to the potentiometer
int potValue = 0; // variable that holds the potetiometer value
String hexValue = "";

void setup() {
  // setup only runs once when the Arduino starts
  // initialize the output ports
  pinMode(potin, INPUT);
// prepare for sending over serial port
  Serial.begin(115200);
}

void loop() {
  readInputs(); 
  Serial.print("HEX:");
  Serial.println(hexValue);
  
// wait for a bit to not overload the port
  delay(10);  
}

/*************
  FUNCTIONS
**************/
void readInputs()
{
  potValue = analogRead(potin); // read the potentiometer value
 

  //Since value of potentiometer is between 0 - 1023, and hex is 16 values, 0-9,A-F,
  //every 64 values will represent a hex value
  if(potValue < 64)
  {
    hexValue = "0";
  }
  else if(potValue >= 64 && potValue < 128 )
  {
    hexValue = "1";
  }
  else if(potValue >= 128 && potValue < 192 )
  {
    hexValue = "2";
  }
  else if(potValue >= 192 && potValue < 256 )
  {
    hexValue = "3";
  }
  else if(potValue >= 256 && potValue < 320 )
  {
    hexValue = "4";
  }
  else if(potValue >= 320 && potValue < 384 )
  {
    hexValue = "5";
  }
  else if(potValue >= 384 && potValue < 448 )
  {
    hexValue = "6";
  }
  else if(potValue >= 448 && potValue < 512 )
  {
    hexValue = "7";
  }
  else if(potValue >= 512 && potValue < 576 )
  {
    hexValue = "8";
  }
  else if(potValue >= 576 && potValue < 640 )
  {
    hexValue = "9";
  }
  else if(potValue >= 640 && potValue < 704 )
  {
    hexValue = "A";
  }
  else if(potValue >= 704 && potValue < 768 )
  {
    hexValue = "B";
  }
  else if(potValue >= 768 && potValue < 832 )
  {
    hexValue = "C";
  }
  else if(potValue >= 832 && potValue < 896 )
  {
    hexValue = "D";
  }
  else if(potValue >= 896 && potValue < 960 )
  {
    hexValue = "E";
  }
  else if(potValue >= 960 && potValue < 1024 )
  {
    hexValue = "F";
  }
  
  
}

