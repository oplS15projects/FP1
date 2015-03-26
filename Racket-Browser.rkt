#lang racket
(require browser)

(define (open-reddit)
  (open-url "http://www.reddit.com"))

(define (open-github)
  (open-url "http://www.github.com"))

(define (toggle-images)
  (html-img-ok (not (html-img-ok))))


