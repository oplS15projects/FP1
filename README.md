# Final Project Assignment 1: Exploration (FP1)
DUE March 25, 2015 Wednesday (2015-03-25)

## My Library: SGL (Racket OpenGL Library)
For this assignment, I decided to use SGL to explore graphics in Racket. SGL is an OpenGL wrapper for Racket that allows
the user to display 2D and 3D graphics. For the purposes of my assignment, I will only be delving into 2D graphics, because
I do not know anything about 3D graphics.

To begin with, I found the documentation for SGL at [http://docs.racket-lang.org/sgl/index.html](http://docs.racket-lang.org/sgl/index.html),
but there is no actual documentation of what each procedure does. For this, I had to find the official OpenGL documentation to learn what each
procedure did, and then find the relevant procedure in the Racket documentation. The official OpenGL documentation is found [here](https://www.opengl.org/sdk/docs/man2/xhtml/).

The official documentation is very helpful, but the problem is that I had no basis for how to do something like create a frame to draw in and
begin drawing and how to update the window. So, I did some Googling and found an example of how to create a simple window and draw a triangle on [RosettaCode](http://rosettacode.org/wiki/OpenGL#Racket). This allowed me to at the very least create a window with which I could draw simple shapes in different colors. But this still didn't tell me how to update the window so I could "animate" the graphics. For this, I found a Github project that showed how to create an update procedure that updates the screen so the graphics can be "animated". Using this, I was able to rotate the object I drew so it apppeared to spin, rather than just sit there and do nothing, which would be boring.

All the code for my example can be found in the file "sgl_test.rkt" included in this repository. And here is a screenshot of the output.

![OPL FP1 Output](/sgl_test.png)