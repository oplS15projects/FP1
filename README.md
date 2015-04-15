# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: SGL (OpenGL and Racket/GUI)
I decided to play around with the GUI aspects of Racket and in doing so, decided to play with OpenGL.
Inside the documentation, they made most of the aspects of the C Open GL API to work with Racket.  To start off, I found a "Hello World" starting file online that basically drew a box on the screen like this:

<a href="http://imgur.com/eKXUwOU"><img src="http://i.imgur.com/eKXUwOU.png" title="source: imgur.com" /></a>

The source code didn't seem all to unfamiliar in terms of style.  It reminds me of how SFML worked in terms of how we need to create a window and creating functions to draw materials.
I wanted to create a 3D Cube as my goal for this assignment.  I tried googling everywhere for a specific tutorial on how to use the Racket version of OpenGL but I was unsucessful.  I proceeded to check the documentation for the C OpenGL API and I followed a tutorial.

I had to translate most of the functions into a scheme language but that was trivial.  As a final result, I create a multi-colored 3D cube that has rotational abilities:

<a href="http://imgur.com/QxvnyGC"><img src="http://i.imgur.com/QxvnyGC.png" title="source: imgur.com" /></a>

The tutorial had instructions on how to make it rotate based on WASD.  I am currently figuring out how to implement this function to make it interactive.  I have an overarching goal to somehow graphically display music maybe like how the Windows Media Player displays those funky colors and waves when playing music.  My next goal is to understand basics of any stable music/audio libraries available to/in Racket.
