#lang racket
(require math/number-theory) 
(require math) 
(require math/base)
(require plot)

; for base case we define input by constant number for now
(define input1
  '(exponent 2 3))
(define input2
  '2)
;(define procedure input
;            (cond ((= (car input) 'exponent)
;                        (exponent))
;               (factorials (factorial input2)) 
 ;            else ('(no procedure found))))


; takes input by the user evaluates exponent
(define base-number (car (cdr input1)))
(define power-number (car (cdr (cdr input1))))
 
(define exponent
(expt base-number power-number))
;(expt 2 3)

;checks if the number is prime
(define prime
  (prime? input2))


;logarithmics natural

(define logarithm
  (log input2))

;(plot3d (surface3d (λ (x y) (* (cos (* x x)) (sin y)))
;                     (- pi) pi (- pi) pi)
;          #:title "Sinus cosinus function visually"
;          #:x-label "x" #:y-label "y" #:z-label "cos(x) sin(y)")


 
