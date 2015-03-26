# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

Write your report right in this file. Instructions are below. You can delete them if you like, or just leave them at the bottom.
You are allowed to change/delete anything in this file to make it into your report. It will be public, FYI.

This file is formatted with the [**markdown** language][markdown], so take a glance at how that works.

This file IS your report for the assignment, including code and your story.

Code is super easy in markdown, which you can easily do inline `(require net/url)` or do in whole blocks:
```
#lang racket

(require net/url)

(define myurl (string->url "http://www.cs.uml.edu/"))
(define myport (get-pure-port myurl))
(display-pure-port myport)
```

### My Library: racket/gui/base and racket/draw
Write what you did!
Remember that this report must include:
 
* a narrative of what you did
I followed the examples of the gui library on the racket website. I created a window and put buttons and a message on it. Once I did that I continued editing the windows adding colors, rectangles, and resizable buttons. I looked at the sleep for a window that freezes all interactions with it for a set time. This is in the pause button. When I first creating these buttons and text I really wanted to change the colors. So I looked at the draw library in racket that works with the gui library. Using this I looked at the paint callback in the gui panel and added brushes and pens to alter the color of the different objects on the window. I created a second window to further test the library and drew lines and rectangles of different colors there I added a check box at the bottom of it for fun.

-----------------------------------------------------------------------------------------------------------------------------
* the code that you wrote

Everything up to the next --- line is code.
```
#lang racket

(require racket/gui/base)
(require racket/draw)

;-----------------------------------------------
;Working with GUI and DRAW to play around with windows and create buttons, text, and figures.

; Make a frame by instantiating the frame% class
(define frame (new frame% [label "Window1"]
                   [width 300]
                   [height 300]))

; Make a static text message in the frame
(define msg (new message% [parent frame]
                          [label "Testing GUI"]
                          [auto-resize #t]))
 
; Make a button in the frame
(new button% [parent frame]
             [label "Click Me    "]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send msg set-label "Test Complete"))])

; Derive a new canvas (a drawing window) class to handle events
(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-event event)
      (send msg set-label "Canvas mouse"))
    ; Define overriding method to handle keyboard events
    (define/override (on-char event)
      (send msg set-label "Canvas keyboard"))
    ; Call the superclass init, passing on all init args
    (super-new)))
 
; Make a canvas that handles events in the frame
(new my-canvas% [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send dc set-font (make-font #:size 60 #:family 'roman
                                     #:weight 'bold))
        (send dc set-text-foreground "purple")
        (send dc set-brush "indigo" 'solid)
        (send dc draw-rectangle 0 0 300 80)
        (send dc draw-text "Behold!" 5 1)
        )]
     )

(new button% [parent frame]
             [label "Pause"]
             [callback (lambda (button event) (sleep 5))])

(define panel (new horizontal-panel% [parent frame]))
(new button% [parent panel]
             [label "Left"]
             [callback (lambda (button event)
                         (send msg set-label "Left click"))]
             [stretchable-width #t]	 
   	 	)
(new button% [parent panel]
             [label "Right"]
             [callback (lambda (button event)
                         (send msg set-label "Right click"))]
                       [stretchable-width #t])

	 


(define frame2 (new frame%
                   [label "Window2"]
                   [width 300]
                   [height 300]))
(new canvas% [parent frame2]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-pen "transparent" 1 'solid)
                (send dc set-brush "transparent" 'solid)
                (send dc draw-rectangle 0 0 500 500)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Don't Panic!" 0 0)
                (send dc set-brush "green" 'solid)
                (send dc set-pen "blue" 1 'solid)
                
                (send dc draw-rectangle
                      20 30   ; Top-left at (0, 10), 10 pixels down from top-left
                      30 20) ; 30 pixels wide and 10 pixels high
                (send dc set-pen "red" 2 'solid) 
                (send dc draw-line
                      20 40    ; Start at (0, 0), the top-left corner
                      50 50) ; and draw to (30, 30), the bottom-right corner
                (send dc draw-line
                      50 40   ; Start at (0, 30), the bottom-left corner
                      20 50)  ; and draw to (30, 0), the top-right corner
                (send dc draw-line 25 35 32 35)
                (send dc draw-line 38 35 44 35)
)
               ])
(new check-box%	 
   	 	[label "Check"]	 
   	 	[parent frame2]	 
   	 	[callback (lambda (button event)
                         (send msg set-label "Checked"))]	 	 	 	 
   	 	[min-width 100]	 
   	 	[min-height 100]	 
   	 	)

;Shows Window2
(send frame2 show #t)

; Shows Window1
(send frame show #t)

;---------------------------------------
; Working purely with draw and its output to Dr Racket.

(define target (make-bitmap 30 30)) ; A 30x30 bitmap
(define dc (new bitmap-dc% [bitmap target]))

(send dc draw-rectangle
      0 10   ; Top-left at (0, 10), 10 pixels down from top-left
      30 10) ; 30 pixels wide and 10 pixels high
(send dc draw-line
      0 0    ; Start at (0, 0), the top-left corner
      30 30) ; and draw to (30, 30), the bottom-right corner
(send dc draw-line
      0 30   ; Start at (0, 30), the bottom-left corner
      30 0)  ; and draw to (30, 0), the top-right corner



(send dc set-brush "green" 'solid)
(send dc set-pen "blue" 1 'solid)
(send dc draw-rectangle 0 10 30 10)
(send dc set-pen "red" 3 'solid)
(send dc draw-line 0 0 30 30)
(send dc draw-line 0 30 30 0)

(send dc set-pen "white" 1 'transparent)
(send dc set-brush "black" 'solid)
(send dc draw-ellipse 5 5 20 20)

(make-object image-snip% target)
```
-----------------------------------------------------------------------------------------------------------------------------
This is the end of the code.

* output from your code demonstrating what it produced
* This is the direct output

 (object:button% ...)
(object:my-canvas% ...)
(object:button% ...)
(object:button% ...)
(object:button% ...)
(object:canvas% ...)
(object:check-box% ...)
.

* any diagrams or figures explaining your work 
 I would love to put a picture of my windows here but racket does not seem to like pasting pictures. If you run the above code the two windows I meantion in the beginning will appear.


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
