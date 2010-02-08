import processing.serial.*;

import cc.arduino.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Arduino arduino;
int servoPin = 9;

void setup() {
  size(512, 200);
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  //arduino.pinMode(servoPin, Arduino.OUTPUT);
  
  println("\n    zeroing servo\n");
  arduino.analogWrite(servoPin, 90);
  
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  
  /* osc plug service
   * osc messages with a specific address pattern can be automatically
   * forwarded to a specific method of an object. in this example 
   * a message with address pattern /test will be forwarded to a method
   * test(). below the method test takes 2 arguments - 2 ints. therefore each
   * message with address pattern /test and typetag ii will be forwarded to
   * the method test(int theA, int theB)
   */
  
  oscP5.plug(this,"servo","/servo");
  
}

public void servo( int x ){
  println("### plug event method. received a message /servo.");
  println("    servoWrite: "+x);  
  arduino.analogWrite(servoPin, x);
  // arduino.servoWrite(servoPin, x);
}

void draw() {
  background(constrain(mouseX / 2, 0, 255));
//  arduino.analogWrite(servoPin, constrain(mouseX / 2, 0, 180));
//  arduino.analogWrite(11, constrain(255 - mouseX / 2, 0, 30));
}

void mousePressed() {
  
  OscMessage servoMessage = new OscMessage("/servo");
  
  println("    clicked: " + mouseX);

  servoMessage.add( constrain(mouseX / 2, 0, 175) );

  /* send the message */
  oscP5.send(servoMessage, myRemoteLocation); 
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* with theOscMessage.isPlugged() you check if the osc message has already been
   * forwarded to a plugged method. if theOscMessage.isPlugged()==true, it has already 
   * been forwared to another method in your sketch. theOscMessage.isPlugged() can 
   * be used for double posting but is not required.
  */  
  if(theOscMessage.isPlugged()==false) {
  /* print the address pattern and the typetag of the received OscMessage */
  println("### received an osc message.");
  println("### addrpattern\t"+theOscMessage.addrPattern());
  println("### typetag\t"+theOscMessage.typetag());
  theOscMessage.printData();
  }
}
