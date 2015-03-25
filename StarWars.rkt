#lang racket
(require rsound)
(require rsound/piano-tones)

;Note defintions. This takes a little while to build.

(define e3 (piano-tone 40))
(define f3 (piano-tone 41))
(define f#3 (piano-tone 42))
(define g3 (piano-tone 43))
(define ab3 (piano-tone 44))
(define a3 (piano-tone 45))
(define bb3 (piano-tone 46))
(define b3 (piano-tone 47))
(define c4 (piano-tone 48))
(define c#4 (piano-tone 49))
(define d4 (piano-tone 50))
(define d#4 (piano-tone 51))
(define e4 (piano-tone 52))
(define f4 (piano-tone 53))
(define f#4 (piano-tone 54))
(define g4 (piano-tone 55))
(define ab4 (piano-tone 56))
(define a4 (piano-tone 57))
(define bb4 (piano-tone 58))
(define b4 (piano-tone 59))
(define c5 (piano-tone 60))

;Tempo and note duration defintions. 

(define tempo 1.5)
(define trip (/ .333 tempo))
(define eight (/ .5 tempo))
(define quarter (/ 1 tempo))
(define half (/ 2 tempo))
(define whole (/ 4 tempo))

(define (playNote note length)
  (play note)
  (sleep length))

;;The Star Wars melody!

(playNote g3 trip)
(playNote g3 trip)
(playNote g3 trip)
(playNote c4 half)
(playNote g4 half)
(playNote f4 trip)
(playNote e4 trip)
(playNote d4 trip)
(playNote c5 half)
(playNote g4 quarter)
(playNote f4 trip)
(playNote e4 trip)
(playNote d4 trip)
(playNote c5 half)
(playNote g4 quarter)
(playNote f4 trip)
(playNote e4 trip)
(playNote f4 trip)
(playNote d4 half)













