#lang racket

; Library include
(require games/cards) 

; Create a table to play on
(define table (make-table "52 Pick-up" 13 4))

; Get a deck of cards, shuffle it.
(define deck (shuffle-list (make-deck) 4))

; Place the cards arbitrarily across the table
(map (lambda(x) (send 
                 table 
                 add-card 
                 x 
                 (random (* 12 71))
                 (random (* 3 96))))
     deck)

; Make sure all the cards are face-up
(map (lambda(x) (send
                 x
                 face-up))
     deck)

; Disallow the user's ability to flip the cards
(map (lambda(x) (send
                 x
                 user-can-flip #f))
     deck)

; Define a call-back for a region, any cards here will be flipped face-down
(define (stacked-cards lst)
  (send table cards-face-down lst))
  
; Create a region with the above call-back, and add it to the  table
(define stack-zone (make-region 0 0 100 100 "Stack Here" stacked-cards))
(send table add-region stack-zone)

; Hilite the region at the start
(send table hilite-region stack-zone)

; Show the table
(send table show #t)
