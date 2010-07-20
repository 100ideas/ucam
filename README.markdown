README
======

ucam\_ps3.pde displays the videostream from a modded ps3eye microscope via USB, accepts mouse clicks and drags as user input, and controls a 2-axis servo-powered microscope slide stage via an arduino w/ firmata firmware


requirements
------------

processing ide: <http://processing.org/download/>

video, serial, and arduino libraries for processing (included by default): <http://processing.org/reference/libraries/>.

arduino ide: <http://arduino.cc/en/Main/Software>

ucam hardware platform: <http://diybio.org/ucam>

modded ps3eye: <http://www.dusseiller.ch/labs/?p=912> (I used a small spot of superglue to lightly secure the inverted lens to the lens mount).


setup
-----

1.
upload ServoFirmata\_9\_11.pde to your arduino and connect the servo control wires to the +5v, ground, and digital pins 9 and 11. You will want a breadboard to breakout the power bus to the servos.

On TPro SG90 or HTX900 microservos, the wiring colors correspond to: 

- yellow: control
- red: 5 volts
- brown: ground

2.
run ucam\_ps3.pde in processing and click around.



last updated: 20 Jul 2010