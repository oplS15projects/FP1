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

### My Library: gui
Write what you did!

 I followed the tutorial for the racked documented gui library and played around with the different ways to set up an interactive gui. I wrote code for an initial window, a dialogue, and a second window with gui buttons. After closing the first window the second window will open. The second window has buttons with a display to show if they are pressed. An event canvus will display different text when buttons are pressed. A pause button will freeze the window temporarily, as seen by the gauge. There are many other interactive "widgets" that are in the rest of the window. Many are just there for an example of the type, some will allow for the user to change them.


```

#lang racket

(require racket/gui/base)

;Author:Nicholas Forsyth, nicholas_forsyth@student.uml.edu
;This program was made by using Racket document tutorials.
;Comments from the tutorial are kept for clarity.

; Make a frame by instantiating the frame% class
(define frame (new frame%
                   [label "Gui Examples"]
                   [width 1000]
                   [height 700]))
                   ;[style'fullscreen-button ]))

(new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Warning: GUI TESTING" 0 0))])



 
; Make a static text message in the frame
(define msg (new message% [parent frame]
                          [label "No events so far..."]))
 
; Make a button in the frame
(new button% [parent frame]
             [label "Click Me"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send msg set-label "Button click"))])
 
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
     [style (list 'vscroll 'hscroll )])

(new button% [parent frame]
             [label "Pause"]
             [callback (lambda (button event) (sleep 5))])

(define panel (new horizontal-panel% [parent frame] ))
(new button% [parent panel]
             [label "Left"]
             [callback (lambda (button event)
                         (send msg set-label "Left click"))])
(new button% [parent panel]
             [label "Right"]
             [callback (lambda (button event)
                         (send msg set-label "Right click"))])

; Create a dialog
(define dialog (instantiate dialog% ("Please close me")))
 
; Add a text field to the dialog
(new text-field% [parent dialog] [label "Your name"])
 
; Add a horizontal panel to the dialog, with centering for buttons
(define panel2 (new horizontal-panel% [parent dialog]
                                     [alignment '(center center)]))
 
; Add Cancel and Ok buttons to the horizontal panel
(new button% [parent panel2] [label "Cancel"])
(new button% [parent panel2] [label "Ok"])
(when (system-position-ok-before-cancel?)
  (send panel2 change-children reverse))
 


; Show the dialog
(send dialog show #t)

(define panel3 (new horizontal-panel% [parent frame] ))

(let ([new-es (make-eventspace)])
  (parameterize ([current-eventspace new-es])
    (new frame% [label "Example"])))

(define check-box (new check-box%
                       (parent panel)
                       (label "Check Box")
                       (value #t)))


;(struct gui-event (start end name) #:prefab)

(define choice (new choice%
                    (label "Choice")
                    (parent panel3)
                    (choices (list "Item 0" "GUI is fun!"))))

(define combo-field (new combo-field%
                         (label "Combo")
                         (parent panel3)
                         (choices (list "Field"))
                         (init-value "Field")))

(define editor-canvas (new editor-canvas%
                           (parent panel3)
                           (label "Editor Canvas")))
(define text (new text%))
(send text insert "Editor Canvas")
(send editor-canvas set-editor text)

(define panel4 (new horizontal-panel% [parent frame]))
(define gauge (new gauge%
                   (label "Gauge")
                   (parent panel4)
                   (range 100)))
(send gauge set-value 42)

(define group-box-panel (new group-box-panel%
                             (parent panel4)
                             (label "Group Box Panel")))

(define list-box (new list-box%
                      (label "List Box")
                      (parent (new horizontal-panel%
                                   (parent panel4)
                                   (style (list 'border))))
                      (choices (list "Item 0"
                                     "Item 1"
                                     "Item 2"))
                      (style (list 'single
                                   'column-headers))
                      (columns (list "First Column"))))

(define menu-bar (new menu-bar%
                      (parent frame)))
(new menu%
     (label "&File")
     (parent menu-bar))
(new menu%
     (label "&Edit")
     (parent menu-bar))
(new menu%
     (label "&Help")
     (parent menu-bar))
(new menu%
     (label "&Winning")
     (parent menu-bar))

(define message (new message%
                     (parent panel)
                     (label "Lots of stuff to click.")))

(define a-panel (new panel%
                     (parent panel4)
                     (style (list 'border))))
(new message%
     (parent a-panel)
     (label "Panels"))

(define radio-box (new radio-box%
                       (label "Radio Box")
                       (parent panel4)
                       (choices (list "Button 0"
                                      "Button 1"
                                      "Button 2"))))

(define panel5 (new horizontal-panel% [parent frame] ))

(define slider (new slider%
                    (label "Slider")
                    (parent panel5)
                    (min-value 0)
                    (max-value 100)
                    (init-value 42)))

(define tab-panel (new tab-panel%
                       (parent panel5)
                       (choices (list "Tab 0"
                                      "Tab 1"
                                      "Tab 2"))))

(define text-field (new text-field%
                        (label "Text")
                        (parent panel5)
                        (init-value "Field")))




; Show the frame by calling its show method
(send frame show #t)

```
Output:
(object:canvas% ...)
(object:button% ...)
(object:my-canvas% ...)
(object:button% ...)
(object:button% ...)
(object:button% ...)
(object:text-field% ...)
(object:button% ...)
(object:button% ...)
(object:frame% ...)
(object:menu% ...)
(object:menu% ...)
(object:menu% ...)
(object:menu% ...)
(object:message% ...)

It's a little clearer with a picture of the windows; I do not know how to include one though. The windows created by the code are the program's output.

Looks like this:
```
 ------------------------------------------------------
  |              -------------------------------------   |
  |  Your name: |                                     |  |
  |              -------------------------------------   |
  |                    --------     ----                 |
  |                   ( Cancel )   ( OK )                |
  |                    --------     ----                 |
   ------------------------------------------------------
```

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
