import processing.serial.*;
import cc.arduino.*;
import TUIO.*;

Arduino arduino;
int servoPin = 9;

TuioProcessing tuioClient;

final static float tuioCursorSpeedMult = 0.02f; // the iphone screen is so small, easy to rack up huge velocities! need to scale down 
final static float tuioStationaryForce = 0.001; // force exerted when cursor is stationary

boolean tuioDoubleTap = false;

int xmap = 0;  //holds tuio cursor x-movement


void setup() {
  size(512, 200);
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  //arduino.pinMode(servoPin, Arduino.OUTPUT);
  
  println("\n    zeroing servo\n");
  arduino.analogWrite(servoPin, 90);

  // init TUIO
  tuioClient  = new TuioProcessing(this);

}

public void servo( int x ){
  println("### plug event method. received a message /servo.");
  println("    servoWrite: "+x);  
  arduino.analogWrite(servoPin, x);
}

void updateTUIO() {
    Vector tuioCursorList = tuioClient.getTuioCursors();
    //println("tuio found " + tuioCursorList.size() + "cursors");
    for (int i=0;i<tuioCursorList.size();i++) {
        TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
        float vx = tcur.getXSpeed() * tuioCursorSpeedMult;
        float vy = tcur.getYSpeed() * tuioCursorSpeedMult;
        /* if(vx == 0 && vy == 0) {
            vx = random(-tuioStationaryForce, tuioStationaryForce);
            vy = random(-tuioStationaryForce, tuioStationaryForce);
        }
        addForce(tcur.getX(), tcur.getY(), vx, vy); */
        int xmap = round ( map( tcur.getX(), 0, 1, 30, 150 ) );
        println( xmap );
        arduino.analogWrite(servoPin, xmap );
    }
}

void draw() {
  updateTUIO();
  
  background(constrain(mouseX / 2, 0, 255));
//  arduino.analogWrite(servoPin, constrain(mouseX / 2, 0, 180));
//  arduino.analogWrite(11, constrain(255 - mouseX / 2, 0, 30));
}

void mousePressed() {
  
  println("    clicked: " + mouseX);

}

// TUIOLIB required methods


void addTuioObject(TuioObject tobj) {
}

void updateTuioObject(TuioObject tobj) {
}

void removeTuioObject(TuioObject tobj) {
}

void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  //println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  //println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

void refresh(TuioTime bundleTime) {
  redraw();
}
