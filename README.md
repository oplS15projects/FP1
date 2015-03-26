# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: racket/draw and also racket/gui/base

For this exploration, I wanted to see if I could make some kind of simple game. At first I tried using the 2htdp/image library but couldn't seem to make sense of it. I think I would have a much easier time trying to use it if I could find some examples or something. Maybe I'll look into that for the next exploration. 
Anyway, I used racket/gui/base to make a window. After a while of trying to use 2htdp/image I switched to racket/draw and managed to get a rectangle to move in the window. I really just expanded from there. I made maps which are lists of lists of numbers. Each frame, the draw function draws a square in the proper place using the draw-rectangle function from racket/draw.

![](/images/firstpart1.png)

![](/images/firstpart2.png)

![](/images/firstpart3.png)


```
#lang racket

(require racket/gui/base)
(require racket/draw)

;;**********************************************************************

(define nil '())

(define (accumulate op initial sequence)
 (if (null? sequence)
     initial
     (op (car sequence)
         (accumulate op initial (cdr sequence)))))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;;**********************************************************************


;;************************* STUFF FOR SPRITES **************************

(define (update-sprites)
  (set! MY-SPRITES (map (lambda (x) ((update-method x) x)) MY-SPRITES)))

(define (draw-sprites theSprites dc)
  (map (lambda (x) ((draw-method x) dc x)) theSprites))

(define make-sprite list)

(define name first)
(define draw-method second)
(define update-method third)
(define realX fourth)
(define realY fifth)
(define state sixth)
(define (gridX sprite)
  (floor (/ (realX sprite) 40)))
(define (gridY sprite)
  (floor (/ (realY sprite) 40)))

(define (player? sprite)
  (if (eq? (name sprite) "player")
      #t
      #f))

(define (sprite-change-coords sprite x y)
  (make-sprite (name sprite) (draw-method sprite) (update-method sprite) x y (state sprite)))

(define (sprite-change-state sprite new-state)
  (make-sprite (name sprite) (draw-method sprite) (update-method sprite) (realX sprite) (realY sprite) new-state))

(define (change-player-state new-state)
  (map (lambda (x) (if (player? x)
                       (sprite-change-state x new-state)
                       x))
       MY-SPRITES))

(define (get-player)
  (define (help-me sprite)
    (if (eq? sprite nil)
        sprite
        (name sprite)))
  (help-me (filter (lambda (x) (if (eq? (name x) "player") #t #f)) MY-SPRITES)))

(define (player-coin-collision sprite x y)
  (cond ((and (eq? (name sprite) "coin")
              (> (+ x 20) (realX sprite))
              (< x (+ (realX sprite) 10))
              (> (+ y 20) (realY sprite))
              (< y (+ (realY sprite) 10)))
         (set! coin-count (+ coin-count 1))
         #t)
        (else #f)))

(define (player-enemy-collision sprite x y)
  (if (and (eq? (name sprite) "enemy")
           (> (+ x 20) (realX sprite))
           (< x (+ (realX sprite) 30))
           (> (+ y 20) (realY sprite))
           (< y (+ (realY sprite) 30)))
      #t
      #f))

;; FOR HIT DETECTION WITH WALLS
(define (sprite-sub-x sprite)
  (cond ((and (= 1 (tile-at-xy MY-MAP (- (gridX sprite) 1) (gridY sprite))) 
              (<= (realX sprite) (* 40 (gridX sprite))))
         (realX sprite))
        ((and (= 1 (tile-at-xy MY-MAP (- (gridX sprite) 1) (+ (gridY sprite) 1))) 
              (> (realY sprite) (+ 20(* 40 (gridY sprite)))) 
              (<= (realX sprite) (* 40 (gridX sprite))))
         (realX sprite))
        (else (- (realX sprite) 2))))
(define (sprite-add-x sprite)
  (cond ((and (= 1 (tile-at-xy MY-MAP (+ (gridX sprite) 1) (gridY sprite))) 
              (>= (realX sprite) (+ 20 (* 40 (gridX sprite)))))
         (realX sprite))
        ((and (= 1 (tile-at-xy MY-MAP (+ (gridX sprite) 1) (+ (gridY sprite) 1))) 
              (> (realY sprite) (+ 20(* 40 (gridY sprite)))) 
              (>= (realX sprite) (+ 20 (* 40 (gridX sprite)))))
         (realX sprite))
        (else (+ (realX sprite) 2))))
(define (sprite-sub-y sprite)
  (cond ((and (= 1 (tile-at-xy MY-MAP (gridX sprite) (- (gridY sprite) 1))) 
              (<= (realY sprite) (* 40 (gridY sprite))))
         (realY sprite))
        ((and (= 1 (tile-at-xy MY-MAP (+ (gridX sprite) 1) (- (gridY sprite) 1))) 
              (> (realX sprite) (+ 20(* 40 (gridX sprite)))) 
              (<= (realY sprite) (* 40 (gridY sprite))))
         (realY sprite))
        (else (- (realY sprite) 2))))
(define (sprite-add-y sprite)
  (cond ((and (= 1 (tile-at-xy MY-MAP (gridX sprite) (+ (gridY sprite) 1))) 
              (>= (realY sprite) (+ 20 (* 40 (gridY sprite)))))
         (realY sprite))
        ((and (= 1 (tile-at-xy MY-MAP (+ (gridX sprite) 1) (+ (gridY sprite) 1))) 
              (> (realX sprite) (+ 20(* 40 (gridX sprite)))) 
              (>= (realY sprite) (+ 20 (* 40 (gridY sprite)))))
         (realY sprite))
        (else (+ (realY sprite) 2))))

;; ************** SPRITE DRAW FUNCTIONS **************
(define (player-draw-method dc sprite)
  (send dc set-brush "blue" 'solid)
  (send dc draw-rectangle (realX sprite) (realY sprite) 20 20))

(define (enemy-draw-method dc sprite)
  (send dc set-brush "red" 'solid)
  (send dc draw-rectangle (realX sprite) (realY sprite) 30 30)
  (send dc set-text-foreground "black")
  (send dc draw-text ">=(" (+ 25 (realX sprite)) (realY sprite) #t 0 4.740))

(define (coin-draw-method dc sprite)
  (send dc set-brush "yellow" 'solid)
  (send dc draw-ellipse (realX sprite) (realY sprite) 10 10)
  (send dc set-text-foreground "white")
  (if (< (state sprite) 23)
      (send dc draw-text "+" (+ (realX sprite) 3) (+ (realY sprite) 5) #f 0 3)
      (send dc draw-text "+" (+ (realX sprite) 9) (- (realY sprite) 2) #f 0 6)))
;; *****************************************************

;; ************** SPRITE UPDATE FUNCTIONS **************
(define (player-update-method sprite)
  (cond ((= 2 (tile-at-xy MY-MAP (gridX sprite) (gridY sprite)))
         (set! update-map-flag 1)
         (set! map-number (+ map-number 1))
         (sprite-change-coords sprite 0 0))
        ((= (state sprite) 0)
         (sprite-change-coords sprite (sprite-sub-x sprite) (realY sprite)))
        ((= (state sprite) 1)
         (sprite-change-coords sprite (realX sprite) (sprite-sub-y sprite)))
        ((= (state sprite) 2)
         (sprite-change-coords sprite (sprite-add-x sprite) (realY sprite)))
        ((= (state sprite) 3)
         (sprite-change-coords sprite (realX sprite) (sprite-add-y sprite)))
        (else (sprite-change-coords sprite (realX sprite) (realY sprite)))))

(define (enemy-update-method sprite)
  (cond ((and (= 1 (tile-at-xy MY-MAP (+ (gridX sprite) 1) (gridY sprite))) 
              (= 0 (state sprite))
              (>= (realX sprite) (+ (* 40 (gridX sprite)) 10)))
         (sprite-change-state sprite 1))
        ((= 0 (state sprite)) 
         (sprite-change-coords sprite (+ (realX sprite) 1) (realY sprite)))
        ((and (= 1 (tile-at-xy MY-MAP (gridX sprite) (gridY sprite))) 
              (= 1 (state sprite))) 
         (sprite-change-state sprite 0))
        (else (sprite-change-coords sprite (- (realX sprite) 1) (realY sprite)))))

(define (coin-update-method sprite)
  (if (< (state sprite) 48)
      (sprite-change-state sprite (+ 1 (state sprite)))
      (sprite-change-state sprite 0)))
;; *****************************************************

(define coin-count 0)

(define MAP-ONE-SPRITES
  (list (make-sprite "coin" coin-draw-method coin-update-method  95  55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 135  55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 175  55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 205  65 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 215  95 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 225 135 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 215 175 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 205 215 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 215 255 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 225 285 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 255 295 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 295 295 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 335 295 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 365 305 (random 48))
        (make-sprite "enemy" enemy-draw-method enemy-update-method 240 163 0)
        (make-sprite "player" player-draw-method player-update-method 50 50 0)))

(define MAP-TWO-SPRITES
  (list (make-sprite "enemy" enemy-draw-method enemy-update-method 150 164 1)
        (make-sprite "enemy" enemy-draw-method enemy-update-method 240 243 0)
        (make-sprite "coin" coin-draw-method coin-update-method  55 130 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method  77 132 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method  69 147 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method  69 147 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 325 205 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 347 223 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 357 196 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 215 125 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 185 165 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 175 255 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 125 305 (random 48))
        (make-sprite "player" player-draw-method player-update-method 210 40 3)))

(define MAP-THREE-SPRITES
  (list (make-sprite "enemy" enemy-draw-method enemy-update-method 80 125 0)
        (make-sprite "enemy" enemy-draw-method enemy-update-method 233 167 1)
        (make-sprite "enemy" enemy-draw-method enemy-update-method 168 203 0)
        (make-sprite "enemy" enemy-draw-method enemy-update-method 352 284 0)
        (make-sprite "coin" coin-draw-method coin-update-method 255 55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 295 55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 335 55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 255 95 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 295 95 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 335 95 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 255 75 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 295 75 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 335 75 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 275 55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 315 55 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 275 95 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 315 95 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 275 75 (random 48))
        (make-sprite "coin" coin-draw-method coin-update-method 315 75 (random 48))
        (make-sprite "player" player-draw-method player-update-method 0 40 3)))

(define MY-SPRITES MAP-ONE-SPRITES)

;;**********************************************************************


;;*************************** STUFF FOR MAPS ***************************

(define (draw-map theMap dc)
  (define (help-me x y theMap dc)
    (cond ((not (null? theMap))
               (draw-row (car theMap) dc 0 y)
               (help-me (+ x 1) (+ y 1) (cdr theMap) dc))))
  (help-me 0 0 theMap dc))

(define update-map-flag 0)
(define map-number 0)

(define (update-map)
  (cond ((and (= update-map-flag 1) (= map-number 1))
         (set! MY-MAP MAP-TWO)
         (set! MY-SPRITES MAP-TWO-SPRITES)
         (set! update-map-flag 0))
        ((and (= update-map-flag 1) (= map-number 2))
         (set! MY-MAP MAP-THREE)
         (set! MY-SPRITES MAP-THREE-SPRITES)
         (set! update-map-flag 0))
        ((and (= update-map-flag 1) (= map-number 3))
         (set! MY-MAP MAP-ONE)
         (set! MY-SPRITES MAP-ONE-SPRITES)
         (set! update-map-flag 0)
         (set! map-number 0))))

(define (draw-row theRow dc x y)
  (cond ((null? theRow) )
        (else (draw-tile theRow dc x y)
              (draw-row (cdr theRow) dc (+ x 1) y))))

(define (draw-tile theRow dc x y)
  (cond ((= (car theRow) 0) 
         (send dc set-brush "brown" 'solid)
         (send dc draw-rectangle (* 40 x) (* 40 y) 40 40))
        ((= (car theRow) 1) 
         (send dc set-brush "black" 'solid)
         (send dc draw-rectangle (* 40 x) (* 40 y) 40 40))
        ((= (car theRow) 2) 
         (send dc set-brush (make-object color% 179 116 55) 'solid)
         (send dc draw-rectangle (* 40 x) (* 40 y) 40 40)
         (send dc draw-rectangle (+ (* 40 x) 19) (* 40 y) 2 40)
         (send dc set-brush (make-object color% 249 213 16) 'solid)
         (send dc draw-ellipse (+ (* 40 x) 8) (+ (* 40 y) 20) 8 8)
         (send dc draw-ellipse (+ (* 40 x) 24) (+ (* 40 y) 20) 8 8))
        ((= (car theRow) 3) 
         (send dc set-brush "blue" 'solid)
         (send dc draw-rectangle (* 40 x) (* 40 y) 40 40))
        (else 
         (send dc set-brush "green" 'solid)
         (send dc draw-rectangle (* 40 x) (* 40 y) 40 40))))

(define (change-map)
  (set! MY-MAP MAP-TWO)
  (set! MY-SPRITES (list (make-sprite "player" player-draw-method player-update-method 50 50 0))))

(define (tile-at-xy theMap x y)
  (cond ((or (< x 0) (< y 0) (> x 10) (> y 8)) 1)
        ((> y 0) 
         (tile-at-xy (cdr theMap) x (- y 1)))
        (else (car (drop (car theMap) x)))))

(define MAP-ONE (list (list 1 1 1 1 1 1 1 1 1 1 1)
                      (list 1 0 0 0 0 0 1 1 1 1 1)
                      (list 1 1 1 1 0 3 3 3 1 1 1)
                      (list 1 1 1 0 3 3 3 3 1 1 1)
                      (list 1 1 1 1 3 3 3 1 1 1 1)
                      (list 1 1 1 3 3 3 3 0 0 1 1)
                      (list 1 1 1 3 3 0 0 0 1 1 1)
                      (list 1 1 1 1 0 0 0 0 0 0 1)
                      (list 1 1 1 1 1 1 1 1 1 2 1)))

(define MAP-TWO (list (list 1 1 1 1 1 1 1 1 1 1 1)
                      (list 1 1 1 1 1 0 1 1 1 1 1)
                      (list 1 1 1 1 0 0 0 1 1 1 1)
                      (list 1 0 0 0 0 0 0 0 0 0 1)
                      (list 1 0 0 0 0 0 0 1 0 0 1)
                      (list 1 4 4 0 0 1 0 1 0 0 1)
                      (list 1 4 1 1 4 0 0 0 0 1 1)
                      (list 1 4 4 4 4 4 4 0 1 1 1)
                      (list 1 1 2 1 1 1 1 1 1 1 1)))

(define MAP-THREE (list (list 1 1 1 1 1 1 1 1 1 1 1)
                        (list 0 0 0 0 1 1 0 0 0 1 1)
                        (list 1 1 1 0 1 1 0 0 0 0 1)
                        (list 1 1 0 0 1 1 1 1 1 0 1)
                        (list 1 1 0 0 0 0 0 1 1 0 1)
                        (list 1 1 1 1 0 0 1 1 1 0 1)
                        (list 1 1 1 1 0 0 0 0 1 0 1)
                        (list 1 1 1 1 1 1 0 0 0 0 1)
                        (list 1 1 1 1 1 1 1 1 1 1 1)))

(define MY-MAP MAP-ONE)

;;**********************************************************************

(define game-state "playing")

;; UPDATE
(define (update)
  ; update map
  (update-map)
  
  (cond ((eq? (get-player) nil)
         ; GAME OVER
         (set! game-state "game over"))
              ; player collision with coin
        (else (set! MY-SPRITES (filter (lambda (sprite) (not (player-coin-collision sprite (realX (get-player)) (realY (get-player))))) MY-SPRITES))
              ; player collision with enemy
              (set! MY-SPRITES (if (eq? (filter (lambda (sprite) (player-enemy-collision sprite (realX (get-player)) (realY (get-player)))) MY-SPRITES)
                                        nil)
                                   MY-SPRITES
                                   (filter (lambda (x) (not (player? x))) MY-SPRITES)))))
  ; update sprites
  (update-sprites)
  (send canvas refresh))

;; DRAW
(define (draw canvas dc)
  ; draw map
  (draw-map MY-MAP dc)
  ; draw coin count
  (send dc set-text-foreground "yellow")
  (send dc draw-text (string-append "Coins: " (number->string coin-count)) 0 0)
  ; draw sprites
  (draw-sprites MY-SPRITES dc)
  ; game over text
  (cond ((eq? game-state "game over")
         (send dc set-font (make-font #:size 30 #:family 'roman #:weight 'bold))
         (send dc set-text-foreground "red")
         (send dc draw-text "GAME OVER" 100 0)
         (send dc set-font (make-font)))))

;; FRAME
(define frame (new frame%
                   [label "Example"]
                   [width (- 520 64)]
                   [height (- 440 41)]))
;; CANVAS
(define canvas (new (class canvas%
                      (super-new)
                      (define/override (on-char key-event)
                        (cond ((eq? (send key-event get-key-code) 'left)
                               (set! MY-SPRITES (change-player-state 0))
                               (send canvas refresh))
                              ((eq? (send key-event get-key-code) 'up)
                               (set! MY-SPRITES (change-player-state 1))
                               (send canvas refresh))
                              ((eq? (send key-event get-key-code) 'right)
                               (set! MY-SPRITES (change-player-state 2))
                               (send canvas refresh))
                              ((eq? (send key-event get-key-code) 'down)
                               (set! MY-SPRITES (change-player-state 3))
                               (send canvas refresh)))))
                    [parent frame]
                    [paint-callback draw]))

(send frame show #t)

(define timer (new timer% 
                   [notify-callback update]
                   [interval 30]))
```
