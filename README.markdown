ucam
====

ucam is a suite of programs for interacting with and controlling diy 2-axis stages, primarily for controlling microscope slides.

Currently ucam is based off of [processing.org](http://processing.org) and [arduino.cc](http://arduino.cc) code and can control 2 servos attached to an arduino via mouse, keyboard, OSC, or TUIO events.


Setup:
-----

Visit [diybio.org/ucam](http://diybio.org/ucam) for instructions on hacking a cheap webcam into a microscope [TODO: make this into an instructable].

After flashing ServoFirmata_9_11 onto an arduino and attaching servos to pins 9 and 11, tuio events can be used to control the servos via arduino_osx_servo_tuio.

Requires arduino, TUIO, and oscP5 processing libraries, as well as the firmata v2.1 arduino library.

*last updated: 8 Feb 2010*