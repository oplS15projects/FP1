# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: (library name here)
Write what you did!
Remember that this report must include:
 
* a narrative of what you did

A program that reads music notes and outputs music with piano tune.

* the code that you wrote

```
; these are the libraries I used.
(require rsound)
(require rsound/piano-tones) 
...
; Music notes are defined as piano tones
(define F3 (piano-tone 53))
(define G3 (piano-tone 55))
...
; A procedure that takes an arbituary amount of rsounds and returns an rsound that plays them simultaneously.
(define (group-rsound-args head . tail)
  (rs-overlay* (append (list head) tail)))
...
; A procedure that takes a list of rsound and assemble them to an rsound that plays in a fixed interval.
(define (group-rsound-with-delay rsound-lst time-delay)
  (assemble ; (assemble (list (list r-sound timestamp) (list ...))
   (map 
   (lambda (x y) (list x y))
   rsound-lst 
   (map (lambda (z) (* z time-delay)) (range (length rsound-lst))))))
...
; One of the rsound creation. The list contains the music notes, and the last number is the time interval.
(define right-hand (group-rsound-with-delay (list E G3 E G3 F G3 G G3 
                                G A3 F A3 E G3 D F3 
                                C E3 C E3 D G3 E G3 
                                D F3 C F3 C) 10000))
...
```

* output from your code demonstrating what it produced
* 
* "played sound"
* last part of "Ode to joy" is played through the speakers.


* any diagrams or figures explaining your work 
* None

