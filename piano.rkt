#lang racket
(require rsound)
(require rsound/piano-tones)

(define C2 (piano-tone 36))
(define C3 (piano-tone 48))
(define E3 (piano-tone 52))
(define F3 (piano-tone 53))
(define G3 (piano-tone 55))
(define A3 (piano-tone 57))
(define C (piano-tone 60))
(define D (piano-tone 62))
(define E (piano-tone 64))
(define F (piano-tone 65))
(define G (piano-tone 67))
(define C5 (piano-tone 72))

(define (group-rsound-args head . tail) ; groups and returns r-sound
  (rs-overlay* (append (list head) tail)))

(define (group-rsound-list lst)
  (rs-overlay* lst))

(define EG
 (group-rsound-args E3 G3))

(define (group-rsound-with-delay rsound-lst time-delay) ; returns r-sound
  (assemble ; (assemble (list (list r-sound timestamp) (list ...))
   (map 
   (lambda (x y) (list x y))
   rsound-lst 
   (map (lambda (z) (* z time-delay)) (range (length rsound-lst))))))

(define right-hand (group-rsound-with-delay (list E G3 E G3 F G3 G G3 
                                G A3 F A3 E G3 D F3 
                                C E3 C E3 D G3 E G3 
                                D F3 C F3 C) 10000))

(define left-hand (group-rsound-with-delay (list C3 G3 C3 G3 C3 G3 C3 G3 
                                A3 F3 A3 F3 A3 F3 A3 F3
                                C3 G3 C3 G3 C3 G3 C3 G3 
                                D F3 C F3 EG) 10000))

(define ode-to-joy (group-rsound-args right-hand left-hand))

(play ode-to-joy)

;(define (make-a-song notes-in-quotes interval)
;  (group-rsound-with-delay (quasiquote (unquote notes-in-quotes interval))
