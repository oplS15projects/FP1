# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

### My Library: racket/gui

I chose the GUI library from racket because user interface is a must later in the project. 

I followed the windowing tutorial on racket, and expanded it a little bit. I make a tiny program (game?) that counts the clicks on the button, and display various cheering messages during different scores. 
I learned to use frame, message, button, and the arguments that each of them takes. 
Bonus: Found the way the modify global constant.

Code:
```
#lang racket/gui

(require racket/gui/base)

;; main window frame
(define frame (new frame% 
                   [label "Click Counter?"]
                   [width 300]
                   [height 400]
                   ))


;;;;; Score realted ;;;;;

;; total clicked times
(define sum 0)

;; use to transder interger into string
(define (score-count x)
  (cond
    [(eq? x 0) "Score"]
    [(> x 0) (number->string x)]))

;; use to add 1 to global var 'sum'
(define (increase-sum)
  (set! sum (add1 sum)))

;;;;;;;;;;;;;;;;;;;;;;;;


;; define horizontal panel
(define panel (new horizontal-panel% 
                   [parent frame]
                   [vert-margin 1]
                   [alignment '(center center)]))

;; shows the letter 'Score:'
(define score (new message% [parent panel]           
                   [label "Score:"]
                   [auto-resize 1]))

;; shows the current score
(define score-points (new message% [parent panel]           
                   [label "  "]
                   [auto-resize 1]))


;; message telling user how to start 
(define msg (new message% 
                 [parent frame]
                 [label "Click here to start"]
                 [auto-resize 1]))

;; the button that takes the count and different cheer up messages
(new button% [parent frame]
     [label "Click Here"]
     [callback (lambda (button event)
                 (begin
                   (increase-sum)
                   (send score-points set-label (score-count sum))
                     (cond
                       [(< sum 1) (send msg set-label "Click here to start")]
                       [(< sum 5) (send msg set-label "You're doing good!")]
                       [(< sum 10) (send msg set-label "Amazing!!")]
                       [(< sum 15) (send msg set-label "Wow. That finger.")]
                       [(< sum 30) (send msg set-label "Don't stop clicking...")]
                       [else (send msg set-label "Stop it bro too much fun")]

                       ))
                 )])

;; exit button
(new button% [parent frame]
     [label "Exit"]
     [callback (lambda (x y) (exit))])

;; show main frame
(send frame show #t)
```

Output:
It has a window. It prints the score in the middle of the frame. It has 2 buttons, Click Counter and Exit.
When you click on "Click Here", score + 1.
No time limit, have fun.
