# Final Project Assignment 1: Exploration (FP1) 
Alex Li

### My Library: games/cards
Summary: In exploration1, I decided to test out the games/cards library. In my code, I first created a table/window and made it visible. I then sent the table a deck of cards and fanned them out from the top left to the bottom right. Lastly, I created a region named flip which when a card or cards were dragged inside of it, they would be flipped

Code:
```
#lang racket
(require games/cards)

(define tester (make-table "Table" 8 4))
(send tester show #t)
(define deck (send tester all-cards))
(define region-test (make-region 0 0 400 400 #f #f))
(send tester add-cards-to-region (make-deck) region-test)
(define flip (lambda (i) (send tester flip-cards i)))
(define flip-button (make-region 300 0 100 100 "FLIP" flip))
(send tester add-region flip-button)
```
