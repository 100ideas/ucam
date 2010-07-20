import processing.video.*;
import processing.serial.*;
import cc.arduino.*;

Capture cam;
Arduino arduino;

PImage img; 
boolean newFrame=false; 
int servoX = 9;
int servoY = 11;
int mapX = 0;
int mapY = 0;

void setup() {
  size(1280, 960);  // Change size to 320 x 240 if too slow at 640 x 480
 
  // list all available capture devices to the console to find your camera.
  // your system may differ from mine - look for the "USB Video Class Video"
  // printed from the device array provide that index below
  String[] devices = Capture.list();
  println(devices);
  
  // Change devices[7] to the proper index for your camera.
  //isight = new Capture(this, width, height, devices[7]); // isight identically named to ext. usb camera?
  cam = new Capture(this, width, height, devices[7]);
  //isight = null; //get rid of isight object since we just use it to help select the external cam

  // Opens the settings page for this capture device.
  //camera.settings();
  
  
   arduino = new Arduino(this, Arduino.list()[0], 57600);
  //arduino.pinMode(servoPin, Arduino.OUTPUT);
  
  println("\n    zeroing servos\n");
  arduino.analogWrite(servoX, 90);
  arduino.analogWrite(servoY, 90);
  for (int i=0;i<180;i++) {
    servo( i );
    delay(100);
  }
  
}

public void servo( int x ){
  println("### plug event method. received a message /servo.");
  println("    servoXWrite: "+x);  
  arduino.analogWrite(servoX, x);
}

void updatePosition() {
        mapX = round ( map( mouseX, 0, width, 30, 150 ) );
        mapY = round ( map( mouseY, 0, height, 30, 150 ) );
      //  println("mouse" + mouseX + ", " + mouseY);
      //  println( mapX + ", " + mapY );
        arduino.analogWrite(servoX, mapY );
        arduino.analogWrite(servoY, mapX );
}

void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  image(cam, 0, 0);
   if(mousePressed) {
    updatePosition();
  }
//  arduino.analogWrite(servoPin, constrain(mouseX / 2, 0, 180));
//  arduino.analogWrite(11, constrain(255 - mouseX / 2, 0, 30));
}

void mousePressed() { 
  println("    clicked: " + mouseX);
}


