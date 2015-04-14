#lang racket
(require math/number-theory) 
(require math) 
(require math/base)
(require plot)

(define (my_math)

 (define my_add
    (lambda (x y) (+ x y)))
 (define my_subtract
    (lambda (x y) (- x y)))
 (define my_expt
   (lambda (base-number power-number) (expt base-number power-number))) 
  (define my_div
    (lambda (x y) (/ x y)))
  (define isprime
    (lambda (x) (prime? x)))
  (define logarithm
    (lambda (x) (log x)))
  (define my_factorial
    (lambda (x) (factorial x)))
  (define my_sinh
    (lambda (x) (sinh x)))
(define my_cosin
  (lambda (x) (cosh)))
  (define my_root
    (lambda (x y) (integer-root x y)))
  
  (define (handler)
   (lambda (action)
    (cond ((eq? action 'subtract) my_subtract)
          ((eq? action 'add) my_add)
          ((eq? action 'exponent) my_expt)
          ((eq? action 'divide) my_div)
          ((eq? action 'prime_check) isprime)
          ((eq? action 'nat_log) logarithm)
          ((eq? action 'factorials) my_factorial)
          ((eq? action 'sinus) my_sinh)
          ((eq? action 'cosh) my_cosin)
          ((eq? action 'root) my_root)
        ;  ((eq? action '))
         ; ((eq? action '))
          (else #f))))
  
  (handler))  

(((my_math) 'add) 1 2)
