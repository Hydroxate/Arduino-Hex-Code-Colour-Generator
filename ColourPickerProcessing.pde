import processing.serial.*;

Serial myPort;        // The serial porthe

char indata[] = new char[256];
// keep track of how many bytes we receive
int charcount = 0;
char values[] = {'F', 'F', 'F', 'F', 'F', 'F'};
String valHex;
String colourHex = "000000";
int colour = 0;
PFont f;


void setup () {
  // set the window size to fullscreen:
  fullScreen();       
  f = createFont("Arial", 16, true); //Create Font
  println(Serial.list());// List all the available serial ports

  myPort = new Serial(this, Serial.list()[1], 115200);  //
  // A serialEvent() is generated when a newline character is received :
  for (int i=0; i<255; i++)
  {
    indata[i] = (char) 0;
  }
}

void draw () {
  // everything happens in the serialEvent()
  while (myPort.available() > 0) 
  {
    char inByte = myPort.readChar(); // read a character
    if (inByte > 32) // it's a non-whitespace characted
    {
      //start building the string
      indata[charcount] = inByte;
      // until we hit a whitespace again
      charcount++;  // increment the nummber of characters received
      if (charcount > 255) // flush string
      {
        charcount = 0;
      }
    } else
    {
      if (charcount > 0) // we have whitespace characters again and data stored in the buffer
      {
        indata[charcount] = (char) 0; // put a null character at the end of the string
        String dataNumstring = new String(indata); // convert from array of char to String
        String[] myList = split(dataNumstring, ':');

        if (myList[0].equals("HEX"))
        {
          String finalstring = new String(myList[1]);
          String numString = trim(finalstring); // trim away any rubbish data
          valHex = numString; // convert to an Integer number
        }
        
        // print out the values to the console for debugging
        print("HEX:");
        println(valHex);
        charcount = 0; // reset the number of characters received
        
        //Add each hex value to string for drawing
        values[colour] = valHex.charAt(0);
        colourHex = "FF"+ values[0] + values[1] + values[2] + values[3] + values[4] + values[5];
      }
    }
  }
  drawMyShape(); // draw a shape according to the values
}

void drawMyShape()
{
  
  fill(unhex(colourHex)); //Convert Hex String to colour value
  rect(0, 0, displayWidth, displayHeight); //draw rect of 
  textAlign(CENTER);
  textFont(f, 20);  
  if (colourHex.equals("FFFFFF"))
  {
    fill(#000000);
  } else {
    fill(#FFFFFF);
  }
  text("RIGHT AND LEFT KEYS TO SWITCH VALUE TO EDIT", (displayWidth / 2 ), (displayHeight / 2) - 60);
  text("UP KEY TO RESET TO FFFFFF", displayWidth / 2, (displayHeight / 2) - 30);
  text("TURN DIAL TO SWITCH VALUE", displayWidth / 2, (displayHeight / 2) + 30);
  text("HEX CODE: " + colourHex.substring(2), displayWidth / 2, (displayHeight / 2) + 60);   
  text("PRESS Q TO EXIT", displayWidth / 2, (displayHeight / 2) + 120);   
}

// if the user presses the keyboard
void keyPressed() 
{  
  if (key == 'q' || key == 'Q')
  { // quit the program
    myPort.stop();
    stop();
    exit();
  }
  if (keyCode == LEFT)
  { //switch colour index to change from 0 to 5, prevents array index problem
    if ( colour == 0)
    {
      colour = 5;
    } else if (colour >0)
    {
      colour--;
    }
  }
  if (keyCode == RIGHT)
  { //switch colour index to change from 5 to 0, prevents array index problem
    if ( colour == 5)
    {
      colour = 0;
      print("colour");
      println(colour);
    } else if (colour < 5)
    {
      colour++;
      print("colour");
      println(colour);
    }
  }
  if (keyCode == UP)
  { // Reset values to FFFFFF
    for (int i = 0; i < values.length; i++)
    {
      values[i] = 'F';
      //colourHex = "FFFFFFF";
    }
  }
}