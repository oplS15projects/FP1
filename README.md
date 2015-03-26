# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

Write your report right in this file. Instructions are below. You can delete them if you like, or just leave them at the bottom.
You are allowed to change/delete anything in this file to make it into your report. It will be public, FYI.

This file is formatted with the [**markdown** language][markdown], so take a glance at how that works.

This file IS your report for the assignment, including code and your story.

Code is super easy in markdown, which you can easily do inline `(require net/url)` or do in whole blocks:
```
#lang racket

(require net/url)

(define myurl (string->url "http://www.cs.uml.edu/"))
(define myport (get-pure-port myurl))
(display-pure-port myport)
```

### My Library: (library name here)
Write what you did!
Remember that this report must include:
 
* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work 
 
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.

### How to Do and Submit this assignment

1. To start, [**fork** this repository][forking].
1. You might want to [**Clone**][ref-clone] this repository to your computer
  2. (This assignment is just one README.md file, so you can edit it right in github without cloning if you like)
1. Modify the README.md file and [**commit**][ref-commit] changes to complete your solution.
1. [**Push**][ref-push]/sync the changes up to your GitHub (skip this if you didn't clone)
1. [Create a **pull request**][pull-request] on the original repository to turn in the assignment.

<!-- Links -->
[piazza]: https://piazza.com/class/i55is8xqqwhmr?cid=411
[markdown]: https://help.github.com/articles/markdown-basics/
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
[arrow]: http://imgur.com/TUgGqrr

#####Student: Christopher Ly
#####Professor: Mark Sherman
#####Course: OPL
#####Date: 3/25/2015

###Library Explored: arrow.rkt of the How to Design Programs Teachpak / Drawing Toolkit

##Racket Library Exploration 1:

 For the final project my partner and I have vaguely discussed what the project conceptually should be based on. That has yet to be determined, but we do know that we want our project to be implemented in a way visually. I figured it would be wise to select a graphics library when choosing one to explore. Racket has a 'Drawing Toolkit Library' dedicated to creating graphics from basic lines, shapes, colors, transformations, paths, etc... 
  
  Initially this drawing toolkit library was the one I wanted to explore. As I began to explore the library I noticed it did a great job of creating graphics, however, offered little support for manipulation of those created graphics. For our project we not only want to create graphics, but we decided we also want to be able to manipulate them. As a result I ended up looking for another library and came across the 'How to Design Programs Teachpacks' (HtDP) and interestingly enough found a sub-library called 'arrow.rkt'. 
  
  The arrow.rkt sub-library of the HtDP library allows the user the ability to move a graphical object left, right, up, or down. I decided to test the arrow.rkt library and see how the code given as a tutorial on the documentation page worked. The given code demonstrated how to move a graphic right and left using control arrows. I noticed the graphic was created with another sub-library called 'draw.rkt' of the HtDP library and that made me wonder if I could use a graphic created using the drawing toolkit library to be moved left and right. I attempted to implement the control-left-right method of the arrow.rkt library on this graphic of a different library and had very little success. I noticed I wasn't able to move the graphic at all but rather the control create more of the same graphic. I eventually found out the issue was that my movement procedure and the created graphic were associated to two different canvases. The move procedure would work for only one canvas and the graphic was created on another canvas. I am still trying to find a way to connect both to one canvas.
  
  Luckily the HtDP library has the draw.rkt library which links the canvas together with that of the control arrows. With this knowledge I proceeded to implement up and down movement for a graphic and afterwards implement total control (right, left, up, and down) for a single created graphic.
  
####Tested Code:
```
#lang racket

(require racket/gui/base)
(require racket/draw)
(require lang/posn)
(require htdp/draw)
(require htdp/arrow)

; A shape is a structure:
;   (make-posn num num)
 
; RAD : the radius of the simple disk moving across a canvas
(define RAD 10)
(define width 30)
(define height 10)

(define target (make-bitmap 30 30))
(define dc (new bitmap-dc% [bitmap target]))

; move : number shape -> shape or false
; to move a shape by delta according to translate
; effect: to redraw it
(define (move-x delta sh)
  (cond
    [(and (clear-solid-disk sh RAD)
          (draw-solid-disk (translate-x sh delta) RAD))
     (translate-x sh delta)]
    [else false]))
 
(define move-y (lambda (delta sh)
                 (cond [(and (clear-solid-disk sh RAD)
                             (draw-solid-disk (translate-y sh delta) RAD))
                        (translate-y sh delta)]
                       [else false])))

;;Attempting to move a shape created by the racket draw library.
(define move2 (lambda (delta sh)
                (cond
                  [(and (clear-solid-rect sh width height)
                        (draw-solid-rect (translate-x sh delta) width height))
                   (translate-x sh delta)]
                  [else false])))

; translate : shape number -> shape
; to translate a shape by delta in the x direction
(define (translate-x sh delta)
  (make-posn (+ (posn-x sh) delta) (posn-y sh)))

(define translate-y (lambda (sh delta)
                      (posn-x sh) (make-posn (posn-x sh) (+ (posn-y sh) delta))))
  
; draw-it : shape -> true
; to draw a shape on the canvas: a disk with radius
(define (draw-it sh)
  (draw-solid-disk sh RAD 'green))

(define draw-it3 (lambda (sh)
                  (draw-solid-disk sh RAD 'purple)))

;; Attempt to draw a shap from the racket draw library.
(define frame (new frame%
                   [label "Test"]
                   [width 300]
                   [height 250]))

(define draw-it2 (lambda (sh)
                   (new canvas% [parent frame]
                                [paint-callback
                                 (lambda (canvas dc)
                                   (send dc set-brush "green" 'solid)
                                   (send dc set-pen "blue" 1 'solid)
                                   (send dc draw-rectangle 0 10 30 10))])))

; Run:
 
; this creates the canvas
(start 300 250)
;;(send frame show #t)

; this creates the controller GUI
(control-left-right (make-posn 10 20) 10 move-x draw-it)

;;Add Up and down control
(control-up-down (make-posn 10 20) 10 move-y draw-it)

;;Add Total control
(control (make-posn 10 20) 10 move-x move-y draw-it3) 
```  
####Output:

Graphic Movement Output URL: [arrow]

(This is just a still image of the running output. Output is meant to be interactive to see movement.)

