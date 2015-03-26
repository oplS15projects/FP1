# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

```
#lang racket


(require games/cards)

(define table (make-table "Cards" 6 6))

(send table show #t)

(send table add-card (car (make-deck)) 140 0)
(send table add-card (car (make-deck)) 160 0)
(send table add-card (car (make-deck)) 180 0)
(send table add-card (car (make-deck)) 200 0)
(send table add-card (car (make-deck)) 220 0)

(send table add-card (car (make-deck)) 140 466)
(send table add-card (car (make-deck)) 160 466)
(send table add-card (car (make-deck)) 180 466)
(send table add-card (car (make-deck)) 200 466)
(send table add-card (car (make-deck)) 220 466)


```
![Image of Cards](C:\Users\Ronald\Desktop\Capture.png)

### My Library: (Virtual Playing Cards Library)

I was looking at the different libraries, and then I found one that caught my eye. I decided to chose the Virtual Playing Cards Library. It sounds interesting and creating a card game with Racket sounded cool.
Remember that this report must include:
 
* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work 
 





