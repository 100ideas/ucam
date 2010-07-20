import processing.video.*;

Capture cam;
PImage img; 

void setup() {
  size(640, 480);  // Change size to 320 x 240 if too slow at 640 x 480
 
  // list all available capture devices to the console to find your camera.
  // your system may differ from mine - look for the "USB Video Class Video"
  // printed from the device array provide that index below
  String[] devices = Capture.list();
  println(devices);
  
  // Change devices[7] to the proper index for your camera.
  cam = new Capture(this, width, height, devices[7]);
}

void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  image(cam, 0, 0);
}

void mousePressed() { 
  println("    clicked: " + mouseX);
}


