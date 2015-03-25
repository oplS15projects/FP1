# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

######Joshua Caravetta

### My Library: racket/GUI

I decided for the first exploration assignment to look at how a GUI can be created in racket. I decide to use the basic GUI library to complete this task. The fist order of buisness was to see how to create a frame/window, because with out this there is no GUI. To create a basic frame I used the code below.

####Basic Frame Code:

```
#lang racket

(require racket/gui/base)

(define frame (new frame%
                   [label "Canvas Control Example"]
                   [width 400]
                   [height 200]))
(send frame show #t)
```

The output of this code was just a simple frame/window that can be seen below.

pic here::::::::::::::::::::::

I next decided to see how I could add a button on to frame/window because whats a GUI with out buttons. The next iteration of the code that includes a simple button is below.

####Basic Button Code:

```
#lang racket

(require racket/gui/base)

(define frame (new frame%
                   [label "Canvas Control Example"]
                   [width 400]
                   [height 200]))

(new button% [parent frame]
             [label "Button"]
             [callback (lambda (button event) (sleep 5))])
(send frame show #t)
```

The output of the basic button code can be seen below in the screen shot.

pic here::::::::::::::::::::::

After I was able to add the button in I next looked at adding a canvas so that I was able to draw something on the frame of the GUI. The canvas allowed me to draw things such as lines, shapes, and text. I found that in some ways it was alot like the canvas that is seen when using HTML. The code used to generate the canvas is seen below.

####Basic Canvas Code:

```
#lang racket

(require racket/gui/base)

(define frame (new frame%
                   [label "Canvas Control Example"]
                   [width 400]
                   [height 200]))

(define canvas (new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Testing!" 15 0))]))

(send frame show #t)
```

The output of the basic canvas code can be seen in the screen shot below.

pic here:::::::::::::::::::::::

I now decided that since I have these parts on the screen lets try to make them intract with each other. To do this I decided to have two buttons one being start and the other being stop. The start button when clicked will draw the text starting on the canvas, and when the stop button is clicked it will draw the text stopping on the canvas. The code to do this can be seen below.

####Basic Button Canvas Control Code:

```
#lang racket

(require racket/gui/base)

(define frame (new frame%
                   [label "Canvas Control Example"]
                   [width 400]
                   [height 200]))

(define canvas (new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Click a button!" 15 0))]))

(new button% [parent frame]
             [label "Start"]
             [callback (lambda (button event) 
                         (send (send canvas get-dc) clear)
                         (send (send canvas get-dc) set-text-foreground "green")
                         (send (send canvas get-dc) draw-text "Starting" 38 0))])

(new button% [parent frame]
             [label "Stop"]
             [callback (lambda (button event) 
                         (send (send canvas get-dc) clear)
                         (send (send canvas get-dc) set-text-foreground "red")
                         (send (send canvas get-dc) draw-text "Stopping" 38 0))])

(send frame show #t)
```

The output of this code can be seen in the following screen shot.

pic here::::::::::::::::::::::::

I found that the basic GUI library was very easy to pick up and work with, I found that it was alot like how things are handled in JavaScript. I really look forward to expanding my knowledge of the GUI library and mybe tackling harding problems with it.
