# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)
Deleted a lot of the unnecessary text to make the needed points more readable.

### My Library: racket/gui/base ,racket/draw
I mainly went through the given tutorial that was handed to me in the form of the documentation itself.
This was however not the easiest process, since most of the basic concepts linked to another page that linked to another page to explain what the first point had done. I don't really find the use of this library difficult, the event handling point is in itself kind of abstract, I know that that is the point of the langugage, butI would still kind of like to know what it would do in itself. 
In the point ofthe process, I mainly just created a window, and handled a few events, button press and the such with a simple label marker.
Was also introduced to the send primitive point. It's in itself kind of hard to figure without delving more into the implementation library for the send function though.
May be besides the point but found out that I have almost no idea how functions are activiely called in this language... Even though the window is called before some functions, they seem to be able to execute within its context. May be the topic that Professor was trying to explain in detail in class today.

;Don't know at the time how to make things get pushed into the given file program going to post code here directly
```
;;Never used this key in my life... (`) 
#lang racket/gui
(require racket/gui/base)
(require racket/draw)

(define newFrame (new frame% [label "Example"] ))

(define newMsg (new message% [parent newFrame]
                    [label "No events so far"]))

(send newFrame show #t)
(new button% [parent newFrame]
     [label "Click Me!"]
     ;Callback procedure for a button click: Look into this functionality
     [callback (lambda (button event)
                      (send newMsg set-label "Button Click"))])
#|
  Honestly not too sure what this is doing even with the explanations.
  It doesn't seem to affect the given frame or cause anything to happen.
  Actually forgot to print in the explicit declararion for an object of the 
  class canvas...
|#

#|
Creates a canvas on which actions can be made, accepts some events such as keyboard presses
or mouse movements.
The library is starting to become a bit more useful, and intricate.
|#
(define my-canvas%
  (class canvas%
    (define/override (on-event event)
      (send newMsg set-label "Canvas Mouse"))
    (define/override (on-char event)
      (send newMsg set-label "Canvas keyboard"))
    (super-new)))
(new my-canvas% [parent newFrame])
 
;This causes the point of making the program window stop functioning,
;don't see its point yet
(new button% [parent newFrame]
     [label "Pause"]
     [callback (lambda (button event) (sleep 5))])

(define panel (new horizontal-panel% [parent newFrame]))
(new button% [parent panel]
             [label "Left"]
             [callback (lambda (button event)
                         (send newMsg set-label "Left click"))])

(new button% [parent panel]
             [label "Right"]
             [callback (lambda (button event)
                         (send newMsg set-label "Right click"))])

;making a new frame this is getting good
(define frame (new frame%
                   [label "Example"]
                   [width 300]
                   [height 300]))
(new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Don't Panic!" 0 0))])
(send frame show #t)

#|
The documentation is going into detail with everything that the gui class can bring forth
This seems to be a library that will be able to make things work correctly.
I will be delving into either the draw or a more direct sprite controlling library for the 
next object path.
|#
```



Remember that this report must include :
 
* a narrative of what you did --
* the code that you wrote --
* output from your code demonstrating what it produced -- Posting the image to a note in Piazza of the output
* any diagrams or figures explaining your work --Diagram would be better suited for the mass of code aftet
* --The class on friday delving deeper into the focus of how things are fully handled. I do not know how event
* are handled in this language, the documentation is not too explanatory.

### How to Do and Submit this assignment

1. To start, [**fork** this repository][forking].
1. You might want to [**Clone**][ref-clone] this repository to your computer
  2. (This assignment is just one README.md file, so you can edit it right in github without cloning if you like)
1. Modify the README.md file and [**commit**][ref-commit] changes to complete your solution.
1. [**Push**][ref-push]/sync the changes up to your GitHub (skip this if you didn't clone)
1. [Create a **pull request**][pull-request] on the original repository to turn in the assignment.

<!-- Links -->
[piazza]: https://piazza.com/class/i55is8xqqwhmr?cid=411
[markdown]: https://help.github.com/articles/markdown-basics/
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
