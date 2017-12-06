# ECE287_Maze-Project
Final project designed for ECE287 Digital Design

**LogicGateOutput.java**:
  This Java script takes an input coordinates of rectangles (top left (x,y) and bottom right (x,y)), and
outputs the given rectangles into VHDL for both collision detection and for VGA display. 

**ImageToBytes.java**:
  This Java script takes an input image and converts it to a matrix equal to the size of the image [M,N],
with values of either 1 or 0. If the given red channel pixel of the original image is 0, then output a 0,
otherwise output a 1. This script was originally to be implemented into the VHDL file, but due to complications
with compiling large 2D arrays, this was abandoned. This script is included for completeness, and could 
potentially be utilized elsewhere.

**mazeDisplay.m**:
  This matlab script simply takes an image and displays it in matlab. This allows the 'data cursor' tool to
be utilized. The data cursor can then be used to output coordinates of the desired rectangles, to be used in
the LogicGateOutput.java script.
