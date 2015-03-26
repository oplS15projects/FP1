# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)


### My Library: racket/gui


I decided to explore the racket/gui library for my first exploration. I started by making a frame by instantiating a new instance of `frame%`. With the frame created I then decided to try and fill my container with some different controls. I added the controls message, choice, and button. There are many more controls such as combo boxes, list boxes, radio boxes, textfields, sliders, and gauges. I felt what I had was enough to understand how controls interacted with one another and behaved within the frame. All the controls are created the same way as frame by using something like `message%` which is how all my controls were created. I was also able to edit certain fields of my controls such as its parent, height, label, etc.

First, the top-level container the frame had to be instantiated first. I also used some bitmaps

```
(require racket/gui)

(define test-pic (read-bitmap "pic1.jpg"))
(define test-pic2 (read-bitmap "pic2.jpg"))
(define test-pic3 (read-bitmap "pic3.jpg"))

(define frame (new frame% 
                   (label "Example")
                   ;(style '(hide-menu-bar))
                   ;(height 500)
                   ;(width 500)
                   ))
```

I then added more basic controls to the frame and then created some events to see how they worked. I also decided to include a simple text editor for demonstration. An event is invoked to simply change the message, done with `(send msg set-label test-pic)`. When the first button is pressed it gets the index of the choice you made from the choice control and goes through a cond to see what we should set our message to based on the user's choice. The second button acts in a similar way but instead gets user input from the text-field control.

```

(define msg (new message%
                     (parent frame)
                     (label test-pic)))

(define choice (new choice%
                    (parent frame)
                    (label #f)
                    (stretchable-height #t)
                    (choices (list "Test1" "Test2" "Test3"))))

(define txt-field (new text-field%
                       (parent frame)
                       (label #f)))                    
                    
(define button (new button%
                    (parent frame)
                    (label "Test Btn!")
                    (callback (lambda (button event)
                                (cond ((= (send choice get-selection) 0)
                                       (send msg set-label test-pic))
                                      ((= (send choice get-selection) 1)
                                       (send msg set-label test-pic2))
                                      ((= (send choice get-selection) 2)
                                       (send msg set-label test-pic3)))))))
(define button2 (new button%
                     (parent frame)
                     (label "Test Btn!(Txt)")
                     (callback (lambda (button event)
                                 (cond ((equal? (send txt-field get-value)
                                                "one")
                                        (send msg set-label test-pic))
                                       ((equal? (send txt-field get-value)
                                                "two")
                                        (send msg set-label test-pic2))
                                       ((equal? (send txt-field get-value)
                                                "three")
                                        (send msg set-label test-pic3)))))))

(define c (new editor-canvas% (parent frame)))
(define t (new text%))
(send c set-editor t)
(send c set-line-count 10)
(send t insert "An Example Text!")
```
Output :

![Image One](http://i.imgur.com/EYC3XsN.png)

In conclusion, I ended up with a simple gui that will change the message based on my input from the choice or text box. The racket/gui library is extremely easy to work with and well-documented and there are many controls, events, and containers to work with so the library is very versatile.

