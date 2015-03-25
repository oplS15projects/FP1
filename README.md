# Final Project Assignment 1: Exploration (FP1) 

### My Library: images/flomap

For this exploration, I used the images/flomap library to make some image manipulation procedures.
I first created a simple image for demonstration, denoted as `fm`. I then created a procedure to alter saturation (either increase or decrease), and made procedures to enhance or desaturate specific colors (red, blue, and green). It could also be possible to create procedures for other colors based off of the procedures I already created. 

The code I wrote is as follows:
```
#lang racket

(require images/flomap
         racket/draw)

;;http://docs.racket-lang.org/images/index.html
;;http://docs.racket-lang.org/images/flomap_title.html

(define fm
  (draw-flomap
   (lambda (fm-dc)
     (send fm-dc set-alpha 0)
     (send fm-dc set-background "black")
     (send fm-dc clear)
     (send fm-dc set-alpha 1/3)
     (send fm-dc translate 2 2)
     (send fm-dc set-brush "red" 'solid)
     (send fm-dc draw-ellipse 0 0 192 192)
     (send fm-dc set-brush "green" 'solid)
     (send fm-dc draw-ellipse 64 0 192 192)
     (send fm-dc set-brush "blue" 'solid)
     (send fm-dc draw-ellipse 32 44 192 192))
   260 240))
     

(define (saturation fm sat)
  (define-values (x y) (flomap-size fm))
  (define fmsat (build-flomap 1 x y (lambda (k x y) sat)))
  (fm* fm fmsat))

(define (get-red fm)
  (fm* fm (flomap-ref-component fm 1)))
  
(define (enhance-red fm k)
  (define fmred (saturation (get-red fm) k))
  (fm+ fm fmred))

(define (get-green fm)
  (fm* fm (flomap-ref-component fm 2)))
  
(define (enhance-green fm k)
  (define fmgreen (saturation (get-green fm) k))
  (fm+ fm fmgreen))

(define (get-blue fm)
  (fm* fm (flomap-ref-component fm 3)))
  
(define (enhance-blue fm k)
  (define fmblue (saturation (get-blue fm) k))
  (fm+ fm fmblue))
```
The following is `fm`, and the results when `fm` is edited using each of these procedures.
* `fm`:
* ![Imgur](http://i.imgur.com/A9YQoTS.png)
* `saturation`:
* ![Imgur](http://i.imgur.com/VV7vGLL.png)
* `desaturation`:
* ![Imgur](http://i.imgur.com/VYfh4g0.png)
* `enhance-green`:
* ![Imgur](http://i.imgur.com/q7AdtN5.png)
* `enhance-red`:
* ![Imgur](http://i.imgur.com/ymZ14ve.png)
* `enhance-blue`:
* ![Imgur](http://i.imgur.com/swJlEtj.png)
