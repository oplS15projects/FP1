##**Final Project Assignment 1: Exploration (FP1)**


####**Narrative**

Since it is possible that my teams project is a game of some kind, I wanted to explore [Racket's][1] ability to display and overlap images, as well as update the images upon user events (i.e. mouse clicks).  The [Racket Drawing Toolkit][2] seemed a likely package, so I tried it out.

I also created a game-stye menu.  However, the only user event I implemented for that is the "Cancel" button.
*Note*: Since the purpose of this assignment is to explore a graphics library, I did not spend
an abundance of time on the actual game logic; hence the validity of certain moves is dubious.

####**The Code**

[GameMaster.rkt][6] serves as the driver.  Since I tried to use abstraction, efficiently, this code **requires** procedures from [Bitmaps.rkt][3], [ListGenerator.rkt][4], and [MoveSequence][5], so simply copying and pasteing the code below *without* the additional files **will not compile**.

Here is a snipit from [Bitmaps.rkt][3], which demonstrains how I am loading the images (as well as making them available to other files), also using ```#lang racket/gui```:
```
(provide board)

(define board
  (make-object bitmap% "../images/ChessBoard1.jpg"))
```
I did the same for loading images of the pieces, and then generated a list of piece bitmaps.



Here is the entire code from [GameMaster.rkt][6]:
```
#lang racket/gui
;(require racket/draw) ;;for drawing lines on canvas
;(require racket/mpair);;not nesissary(?)
(require "Bitmaps.rkt")
(require "ListGenerator.rkt")
(require "MoveSequence.rkt")

;; create a frame
(define frame
  (instantiate frame%
    ("Racket-Chess")))



;; inherit from class canvas%
(define can
  (class canvas% 
    (override on-event)
    (define on-event (lambda (event)
                       (if (send event button-down? 'any)
                           (if (equal? (moveSequenceMaster (send event get-x) (send event get-y)) #t)
                               (draw-stuff dc)
                               "nested no"
                           )
                           "no"
                       )
                     )
     )
    (super-instantiate () )))



;; create canvas (of my inherited canvas type)
(define my-canvas
  (new can
       (parent frame)
       (min-width  (send board get-width))
       (min-height (+ 200 (send board get-height)))
       (paint-callback
        (lambda (canvasThingy dc)
          (display "callback called\n")
          (draw-stuff dc)))))

(define dc (send my-canvas get-dc))

;; update the GUI
(define (draw-stuff dc)
  (display "redrawing...\n")
  (send dc draw-bitmap board 0 100)
  (define (draw-helper pieceBtmLst pieceCornerLst)
    (cond ( (null? pieceBtmLst)
            nil
          )
          (;else
            (send dc draw-bitmap (car pieceBtmLst) (car (car pieceCornerLst)) (car (cdr (car pieceCornerLst))) )
            (draw-helper (cdr pieceBtmLst) (cdr pieceCornerLst))
          )
    )
  )
  (draw-helper (generatePieceBitmaps) (generatePieceCornerCoors))
)


(send frame show #t)
```

Game menu code:
```
#lang racket/gui

(require racket/gui/base)



(define background
  (read-bitmap "../images/background2.jpg"))

(define frame (new frame%
                   (label "Racket-Chess")
                   ;(width 300)
                   ;(height 250)
               )
)

(new message% [parent frame] [label background])


(define radioPanel (new horizontal-panel% [parent frame]
                                    [alignment '(center center)]))
(define btnPanel (new horizontal-panel% [parent frame]
                                    [alignment '(center center)]))


(new radio-box% [label "Difficulty"]
                (choices '("Easy" "Medium" "Hard"))
                [parent radioPanel])

(new check-box% [label "Attitude"]
                [parent btnPanel])


(define (callback button event)
  (display "\nstart"))
(define (callback2 button event)
  (display "\ncancel")
  (send frame show #f))

(new button% [parent btnPanel]
             [label "START"]
             [callback callback])
(new button% [parent btnPanel]
             [label "CANCEL"]
             [callback callback2])




(send frame show #t)
```


####**GUI Output**

Here is a screenshot after GameMaster.rkt is run:
![ScreenShot0](https://github.com/DeepBlue14/Racket-Chess/blob/master/doc/racketChess0.png)


Here is a screenshot after moving some pieces around:
![ScreenShot1](https://github.com/DeepBlue14/Racket-Chess/blob/master/doc/racketChess1.png)

Here is a screenshot after running "GameMenu.rkt":
![ScreenShot3](https://github.com/DeepBlue14/Racket-Chess/blob/master/doc/racketChess3.png)


####**Console Output (For Debugging)**

To help myself debug and actually tell what each procedure is doing, I have a number of ```display``` commands throughout the program.  Here is the output if, imediatly after the start of the game, the user clicks the square on the left containing a black rook (i.e. "square 1"):
```
@ MoveValidator::findSquare: 1
@ MoveValidator::findSquare: 1
rowNum is: 1
endNum is:1@ MoveValidator::walkThisWay: (#t #t #t #t #t #t #t #t)
endNum is:1@ MoveValidator::walkThisWay: #tsquare is taken

@ MoveValidator::findSquare: 1
@ MoveValidator::findSquare: 1
endNum is:1@ MoveValidator::walkThisWay: ((15 120) (70 120) (125 120) (180 120) (235 120) (290 120) (345 120) (400 120))
endNum is:1@ MoveValidator::walkThisWay: (15 120)
set tmpPiece1X and tmpPiece1Y: 15   120
@ MoveValidator::findSquare: 1
@ MoveValidator::findSquare: 1
******
1
******flipping clicked
redrawing...
``` 

And then when the square (1, 4) is clicked for click #2:
```
@ MoveValidator::findSquare: 1
@ MoveValidator::findSquare: 4
rowNum is: 1
endNum is:4
endNum is:4
endNum is:4
endNum is:4@ MoveValidator::walkThisWay: (#f #f #f #f #f #f #f #f)
endNum is:1@ MoveValidator::walkThisWay: #fsquare is NOT taken

@ MoveValidator::findSquare: 1
@ MoveValidator::findSquare: 4
endNum is:4
endNum is:4
endNum is:4
endNum is:4@ MoveValidator::walkThisWay: ((15 285) (70 285) (125 285) (180 285) (235 285) (290 285) (345 285) (400 285))
endNum is:1@ MoveValidator::walkThisWay: (15 285)
set tmpPiece2X and tmpPiece2Y: 15   285
@ MoveValidator::findSquare: 1
@ MoveValidator::findSquare: 4found match

setting black rook 1flipping clicked
redrawing...
```

*(note change of black rook's position)*
![ScreenShot2](https://github.com/DeepBlue14/Racket-Chess/blob/master/doc/racketChess2.png)







[1]: http://racket-lang.org/
[2]: http://docs.racket-lang.org/draw/index.html?q=
[3]: https://github.com/DeepBlue14/Racket-Chess/blob/master/src/Bitmaps.rkt
[4]: https://github.com/DeepBlue14/Racket-Chess/blob/master/src/ListGenerator.rkt
[5]: https://github.com/DeepBlue14/Racket-Chess/blob/master/src/MoveSequence.rkt
