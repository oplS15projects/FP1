#lang racket

(require plot)

(plot3d (surface3d (λ (x y) (* (cos (* x x)) (sin y)))
                     (- pi) pi (- pi) pi)
          #:title "Final Project Part 1 - Rohit Krishnan"
          #:x-label "x" #:y-label "y" #:z-label "cos(x^2) sin(y)")