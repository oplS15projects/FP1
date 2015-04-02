###My Library: racket/draw

I explored web for small project ideas using lisp and found some on cs.brown.edu and intend to implement one of the games that were written in scheme in Dr Racket. I started exploring libraries related to these applications and learned that The racket/gui/base library provides all of the class, interface, and procedure bindings in addition to the bindings of racket/draw and file/resource. I used sample code provided in the Racket documentation for  racket/draw.

```
#lang racket
(require racket/gui)
(require racket/draw)
(define target (make-bitmap 30 30)) ; A 30x30 bitmap 
(define dc (new bitmap-dc% [bitmap target])) 

(send dc draw-rectangle 
      0 10   ; Top-left at (0, 10), 10 pixels down from top-left 
      30 10) ; 30 pixels wide and 10 pixels high 
(send dc draw-line 
      0 0    ; Start at (0, 0), the top-left corner 
      30 30) ; and draw to (30, 30), the bottom-right corner 
(send dc draw-line 
      0 30   ; Start at (0, 30), the bottom-left corner 
      30 0)  ; and draw to (30, 0), the top-right corner 

;(send target save-file "box.png" 'png)
(make-object image-snip% target)
```
 
 ![Displays:   ](https://github.com/asuris91301/FP1/blob/master/picture1.png)

```
(send dc set-brush "green" 'solid) 
(send dc set-pen "blue" 1 'solid) 
(send dc draw-rectangle 0 10 30 10) 
(send dc set-pen "red" 3 'solid) 
(send dc draw-line 0 0 30 30) 
(send dc draw-line 0 30 30 0)
```
 ![Displays:   ](https://github.com/asuris91301/FP1/blob/master/picture2.png)
 
```
(send dc set-pen "white" 1 'transparent) 
(send dc set-brush "black" 'solid) 
(send dc draw-ellipse 5 5 20 20)
```
 ![Displays:   ](https://github.com/asuris91301/FP1/blob/master/picture3.png)

Adding a face using draw library:
```
#lang racket
(require racket/gui) 
(require racket/draw) 
(require racket/math) 
  
(define no-pen (new pen% [style 'transparent])) 
(define no-brush (new brush% [style 'transparent])) 
(define blue-brush (new brush% [color "blue"])) 
(define yellow-brush (new brush% [color "yellow"])) 
(define red-pen (new pen% [color "red"] [width 2])) 
  
(define (draw-face dc) 
  (send dc set-smoothing 'aligned) 
  
  (send dc set-pen no-pen) 
  (send dc set-brush blue-brush) 
  (send dc draw-ellipse 25 25 100 100) 
  
  (send dc set-brush yellow-brush) 
  (send dc draw-rectangle 50 50 10 10) 
  (send dc draw-rectangle 90 50 10 10) 
  
  (send dc set-brush no-brush) 
  (send dc set-pen red-pen) 
  (send dc draw-arc 37 37 75 75 (* 5/4 pi) (* 7/4 pi))) 
  
(define target (make-bitmap 150 150)) 
(define dc (new bitmap-dc% [bitmap target])) 
  
(draw-face dc) 
(make-object image-snip% target)
```
 ![Displays:   ](https://github.com/asuris91301/FP1/blob/master/picture4.png)
 





