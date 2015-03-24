# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)
Name: Michael Overy

## Library: Cards: Virtual Playing Cards Library

So, before I settled on playing around with this card library, I tried out a few things like openssl and pson but couldn't figure out how to get them to work in a meaningful way, so I decided to pick something relatively easy to work with to become accustomed to the documentation.

As I explored the library, I realized that I would have to do a bit of figuring out how to make a game that has meaning (I would have to play around a lot with regions and different condition checking), so I decided to make a quick game of 52-pick-up.

There are a couple important parts you have to include to be able to play any card-game using this library. First of all, you need a shuffled deck of cards, and a playing space.

```
; Create a table to play on
(define table (make-table "52 Pick-up" 13 4))

; Get a deck of cards, shuffle it.
(define deck (shuffle-list (make-deck) 4))
```

When run, this code will create a window with enough space to fit 13 cards across and 4 cards down side by side. The deck is not yet visible. Since this is a game of 52-pick-up, I want to scatter the cards across the table, so I simply map over the deck sending each card to a random location.

```
; Place the cards arbitrarily across the table
(map (lambda(x) (send 
                 table 
                 add-card 
                 x 
                 (random (* 12 71))
                 (random (* 3 96))))
     deck)
 ```
 
Now, the library already has built in functions that allow the user to move and flip the cards with mouse-clicks and movement. You can alter these permissions depending on what your needs are. 

I didn't want to get too involved in making a complicated game, so I learned a little bit about regions that act as a trigger when cards are moved into it, activating a call-back on the cards you are placing into that region. To show a visual representation that you are playing the game right, I used the following function to flip the cards face-down every time they are placed into the region to show you are stacking them correctly.

```
; Define a call-back for a region, any cards here will be flipped face-down
(define (stacked-cards lst)
  (send table cards-face-down lst))
```

 In the end, I learned a lot about how racket treats cards as objects, they seem to be mutable which we havent dealt with yet and is refreshing given the immutable data we have been working with for the duration of the class. I feel that given sufficient time I could implement games such as solitaire and blackjack with relative ease. After I got used to reading the documentation, working with the library became fairly intuitive.
