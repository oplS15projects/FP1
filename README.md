#### Eugene Stanley
#### eugene.stanley@gmail.com

# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: racket/gui/base

I chose the Racket Graphical Interface Toolkit to play around with. I started by
creating a window, then adding a button to control some text within the window. I
expanded on this first by then making the button toggle the text on and off like
a light switch. I added another control button and switch, so each text could be
manipulated independently. I experimented with different field types, such as radio
buttons, text entry fields, comb-fields, and check boxes. I set up a canvas and 
learned to handle mouse and keyboard events within the canvas. I learned how to 
draw and paint text on a canvas. I created a dialog, and learned how frames are 
used to layout controls. I followed the instructions in the online documentation
to create a simple text editor with drop down menus to support cut and paste 
features.

A screenshot of three of my frames:
![GUI Demo Screenshot](https://github.com/esstanley/FP1/blob/master/demo_capture.PNG)

The code:
```
#lang racket/gui
(require framework)
(require racket/gui/base)

; boolean indicators for two lights
(define toggle_x #f)
(define toggle_x2 #f)

;turns light#1 on
(define (on)
  (send msg1 set-label "On")
  (set! toggle_x #t))
              
;turns light#1 off
(define (off)
  (send msg1 set-label "Off")
   (set! toggle_x #f))

; Make a frame by instantiating the frame% class
(define frame (new frame% 
                   [label "Lights"]
                   [width 300]
                   [height 300]))

; Make a static text message in the frame
(define msg1 (new message% 
                 [parent frame]
                 [label "No events so far..."]))
 
; Make a button in the frame
(new button% [parent frame]
             [label "Light Switch"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (if toggle_x (off) (on)))])

; Make a static text message in the frame
(define msg2 (new message% [parent frame]
                          [label "No events so far..."]))
 
; Make a button in the frame
(new button% [parent frame]
             [label "Light Switch2"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (if toggle_x2 
                             ((send msg2 set-label "Off")
                              (set! toggle_x2 #f)) 
                             ((send msg2 set-label "On")
                              (set! toggle_x2 #t))))])

; message for 3 button panel
(define msg (new message% 
                 [parent frame]
                 [label "No events so far..."]))

; creating a panel for 3 buttons side by side
(define panel2 (new horizontal-panel% 
                    [parent frame]
                    [alignment '(center center)]))
(new button% [parent panel2]
             [label "Left"]
             [callback (lambda (button event)
                         (send msg set-label "Left click"))])
(new button% [parent panel2]
             [label "Center"]
             [callback (lambda (button event)
                         (send msg set-label "Center click"))])
(new button% [parent panel2]
             [label "Right"]
             [callback (lambda (button event)
                         (send msg set-label "Right click"))])


; Show the frame by calling its show method
(send frame show #t)


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

; pause button makes the frame unrespon     sive for 5 seconds
(new button% [parent frame]
             [label "Pause"]
             [callback (lambda (button event) (sleep 5))])

; create a combo box
(new combo-field%
     [label "The Ultimate Question"]
     [choices '("of Life" "of the Universe" "of Everything")]
     [parent frame])



; example of a dialog
; Create a dialog
(define dialog (instantiate dialog% ("TestDialog Box")))
 
; Add a text field to the dialog
(new text-field% [parent dialog] [label "Enter your name"])
 
; Add a horizontal panel to the dialog, with centering for buttons
(define panel (new horizontal-panel% [parent dialog]
                                     [alignment '(center center)]))
 
; Add Cancel and Ok buttons to the horizontal panel
(new button% [parent panel] [label "Cancel"])
(new button% [parent panel] [label "Ok"])
(when (system-position-ok-before-cancel?)
  (send panel change-children reverse))

;painting in a frame
(define frame2 (new frame%
                   [label "The Hitchiker's Guide"]
                   [width 300]
                   [height 300]))
(new canvas% [parent frame2]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Don't Panic!" 0 0)
                (send dc set-scale 2 2)
                (send dc set-text-foreground "red")
                (send dc draw-text "42" 50 50)
                (send dc set-scale 1 1)
                (send dc set-text-foreground "black")
                (send dc draw-text "so long and thanks for all the fish" 0 200)
                )])

(send frame2 show #t)

; text editor frame
(define f (new frame% [label "Simple Edit"]
                      [width 200]
                      [height 200]))
(define c (new editor-canvas% [parent f]))
(define t (new text%))
(send c set-editor t)
(define mb (new menu-bar% [parent f]))
(define m-edit (new menu% [label "Edit"] [parent mb]))
(define m-font (new menu% [label "Font"] [parent mb]))
(append-editor-operation-menu-items m-edit #f)
(append-editor-font-menu-items m-font)
(send f show #t)


; Show the dialog
(send dialog show #t)
 
; Make a canvas that handles events in the frame
(new my-canvas% [parent frame])
```
************************************************************************************************************

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

### My Library: (library name here)
Write what you did!
Remember that this report must include:
 
* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work 
 
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.

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
