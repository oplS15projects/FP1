#lang racket

;; in all definitions, use lambda to create a procedure

;; exercise 1: procedure to square its argument
;; DONE
(define square
  (lambda (n)
    (* n n))) ;; (n^2)

;; exercise 2: write absolute value using the if statement
;; DONE
(define abs-using-if
  (lambda (n)
    (if (= n 0) ;; if n is 0, answer is 0
        0
        (if (> n 0)
            n ;; if n is positive, answer is n
            (* -1 n)) ;; otherwise n is negative, multiply by -1
               )))

;; exercise 3: write absolute value using the cond statement
;; DONE
(define abs-using-cond
  (lambda (n)
    (cond ((< n 0) (* -1 n)) ;; if n is negative, multiply by -1
          ((> n 0) n) ;; if n is positive, it's just n
          ((= n 0) 0)) ;; if n is 0, it's just 0
    ))

;; exercise 4: implement factorial (just copy in the given code)
;; use define syntax
;; DONE
(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))
      ))

;; exercise 5: implement num of combinations of n things taken k at a time,
;; which is n! / k!(n - k)! or simply, "n choose k"
;; DONE
(define comb
  (lambda (n k)
    (cond ((= k 0) 1) ;; There is 1 way to choose nothing out of n
          ((= n k) 1) ;; There is 1 way to choose n elements out of n
          ((< k 0) 0) ;; There are 0 ways to choose - elements out of n
          ((< n 0) 0) ;; There are 0 ways to choose any elements out of -
          (else(/ (fact n) (* (fact k) (fact(- n k)))))) ;; otherwise, perform n choose k
    ))

;; exercise 6: triple its argument
;; DONE
(define triple
  (lambda (n)
    (* 3 n))) ;; (3*n)

;; exercise 7: diff-of-triples
;; should return the first arg tripled minus the second arg tripled
;; DONE
(define diff-of-triples
  (lambda (n m)
    (- (triple n) (triple m)) ;; (3*n) - (3*m)
    ))

;; exercise 8: smallest-of-three
;; returns smallest of three args
;; you may not use the "min" function
;; you may use the boolean "and" function
;; DONE
(define smallest-of-three
  (lambda (a b c)
    (cond ((and (< a b) (< a c)) a) ;; a<b, a<c
          ((and (= a b) (< a c)) a) ;; a==b, a<c
          ((and (= a c) (< a b)) a) ;; a==c, a<b   
          ((and (< b a) (< b c)) b) ;; b<a, b<c
          ((and (= b a) (< b c)) b) ;; b==a, b<c
          ((and (= b c) (< b a)) b) ;; b==c, b<a
          ((and (< c a) (< c b)) c) ;; c<a, c<b
          ((and (= c a) (< c b)) c) ;; c==a, c<b
          ((and (= c b) (< c a)) c) ;; c==b, c<a
          ((and (= a b) (= a c)) a) ;; a==b==c
          )     
    ))

;; exercise 9: smallest-tripled
;; returns tripled value of smallest arg
;; DONE
(define smallest-tripled
  (lambda (a b c)
    (smallest-of-three (triple a) (triple b) (triple c)) ;; multiply all values by 3, then compare
     ))
	 
(provide (all-defined-out))
