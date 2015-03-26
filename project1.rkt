#lang racket

(require plot)
 (plot3d (list (surface3d (λ (x y) (+ (sqr x) (sqr y))) -1 1 -1 1
                           #:label "z = x^2 + y^2")
                (surface3d (λ (x y) (- (+ (sqr x) (sqr y)))) -1 1 -1 1
                           #:color 2 #:line-color 2
                           #:label "z = -x^2 - y^2")))
  (plot3d (surface3d (λ (x y)(* (cos (* x x)) (sin y)))
                    (- pi) pi (- pi) pi)
         #:title "Final Project Task 1 - Pruthviraj Gupta Pabba")
         