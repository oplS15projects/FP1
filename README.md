# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Patrick Quaratiello

Code:

```
#lang racket
(require games/cards)

(define (offset i) 
  (cond((equal? i 0) (values 0 0))
       (else (values (* 72 (modulo i 13)) (* 98 (quotient i 13))))))

(define deck (make-deck))
(define table (make-table "Table" 14 5))
(send table add-cards deck 0 0 offset)	

(send table show #t)

```

My Library: "Cards: Virtual Playing Cards Library"

With this library, I created a seperate popup window used as a "table" that the cards are then placed on using the table procedure. I then created a deck and then placed cards on the previously created table using the deck and add-cards procedure. The cards on the table can be moved by dragging them and flipped over by double clicking them. They have card faces, and the deck procedure creates every card in a deck in order, and then when I placed them on the table they go from King to Ace left to right, and then Spade, Heart, Diamond and Club going down a column.

There should be files showing output, since it's difficult to show them inside a text file.


Remember that this report must include:
 
* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work 

