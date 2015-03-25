# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: GUI Library

My code is at the bottom.
  The library that I have chosen to work with is the [GUI library.][choice]

I used the GUI library to create a simple window and messed around with different parts of it, like windows and a dialog popup.  Originally, I was fairly at a loss, since i had never done anything with GUIs before, but the documentation is good.  I had to look for information in other standard racket libraries since I didn't have full(any) knowledge on things like text boxes and other messages.

Running to code brings up a window, with the Testing title.  Inside it is two horizontal panes and a message.  The first pane contains two buttons.  The first changes the top message to 1 and the second brings up a dialog window, that has its own message, along with another button that will close the dialog.  

The second horizontal pane contains a text field that slowly darkens, and darkens more when there are more letters in it.  It also closes the window when more than 10 letters are input.

I plan on working with this a little more, since I would like to figure out how to make it more aesthetically pleasing, along with possibly making it more fluid to work with.  A toolbar along the top would be the first step.  In addition, there was a section on drawing on a canvas, along with synchronous event handling that I would like to look into further.

In the next library, I would like to look into one of the graphical libraries and hopefully be able to integrate that into the GUI as well.  Possibly making something like MS Paint, or a little simple project like that.

[Pictures of code in action.][pictures]

```
#lang racket

(require racket/gui/base)

;;Creates the top level window
(define frame (new frame%
                   [label "Test Frame"]
                   [width 300]
                   [height 300]))

;;Words for the window
(define msg (new message% [parent frame]
                 [label "Hello"]))

;;Sub Storage for buttons
(define top (new horizontal-panel% [parent frame]
                 ))

(new button% [parent top]
     [label "1"]
     ; Button Click, changes the message
     [callback (lambda (button event)
                 (send msg set-label "1"))])

;; Creaqtes a popup. heh.
(new button% [parent top]
     [label "Popup"]
     [callback (lambda (button event) (popup)
                 )])

(define bottom (new horizontal-panel% [parent frame]
                    ))

(define texty (new text-field% [parent bottom]
                   [label "Ten letters to close"]
                   [callback (lambda (t e)
                               (cond [(< (string-length (send texty get-value)) 10)
                                      (send texty set-field-background 
                                            (make-color 50 60 70 
                                                        (* (string-length (send texty get-value)) .1)))]
                                     [else (send frame show #f)]))]))

(define (popup)
  (define dialog (instantiate dialog% ("POPUP")))
  (define diamsg (new message% [parent dialog]
                      [label "You Haz Viroos!"]))
  (new button% [parent dialog]
       [label "Close"]
       [callback (lambda (button event) (send dialog show #f))])
  
  (send dialog show #t))

(send frame show #t)
```


### How to Do and Submit this assignment




<!-- Links -->
[choice]: http://docs.racket-lang.org/gui/index.html
[pictures]: http://imgur.com/a/zgKml
