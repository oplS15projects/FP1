# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

Write your report right in this file. Instructions are below. You can delete them if you like, or just leave them at the bottom.
You are allowed to change/delete anything in this file to make it into your report. It will be public, FYI.

This file is formatted with the [**markdown** language][markdown], so take a glance at how that works.

This file IS your report for the assignment, including code and your story.

Code is super easy in markdown, which you can easily do inline `(require net/url)` or do in whole blocks:
```
#lang racket

(require net/url)

(define myurl (string->url "http://www.cs.uml.edu/"))
(define myport (get-pure-port myurl))
(display-pure-port myport)
```
I went through couple of libraries to see what options I might have for the project. 

### My Library: Slideshow, pict/flash,  pict/balloon, require pict/face, web-server/insta
* a narrative of what you did:
<br />I went through the documentation and modified the codes given in the documentation, created some fun shapes in different colors. Using  libraries and functions defined in the libraries, I tried creating shapes like circles and colors both filled in with color and empty forms. I tried appending the shapes both vertically and horizontally created attached images. Also, I tried creating simple web applications using web-server/insta.


* the code that you wrote
<br />
;#lang slideshow 

;(circle 25)
;(rectangle 10 20)
;(hc-append (circle 10) (rectangle 10 20))

(define (square n)
  (filled-rectangle n n))
;(square 10)

(define (four p)
  (define two-p (hc-append p p))
  (vc-append two-p two-p))
;(four (circle 10))

(define (checker p1 p2)
  (let ([p12 (hc-append p1 p2)]
        [p21 (hc-append p2 p1)])
    (vc-append p12 p21)))
;(checker (colorize (square 10) "red")
;         (colorize (square 10) "black"))

(define (series mk)
  (hc-append 4 (mk 5) (mk 10) (mk 20)))
;(series circle)

(define (rgb-series mk)
  (vc-append 
   (series (lambda (sz) (colorize (mk sz) "red")))
   (series (lambda (sz) (colorize (mk sz) "green")))
   (series (lambda (sz) (colorize (mk sz) "blue")))))
;(rgb-series circle)

;(list "red" "green" "blue")
;(list (circle 10) (square 10))

(define (rainbow p)
  (map (lambda (color)
         (colorize p color))
       (list "red" "orange" "yellow" "green" "blue" "purple")))
;(rainbow (square 5))

;(apply vc-append (rainbow (square 5)))

(require pict/flash)

;(jack-o-lantern 40)
(define x3 (jack-o-lantern 50 "red" "white"))

(define x1 (angel-wing 50 25 #t))
(define x2 (angel-wing 50 25 #f))

;(hc-append x1 x3 x2 )

;(desktop-machine 1 '(devil plt))

(require pict/balloon)

(define a-pict (standard-fish 50 25))
;(pin-balloon (balloon 25 30 5 'se 5 5)
;               (cc-superimpose (blank 300 150) a-pict)
;               a-pict
;               lc-find)

;(pin-balloon (wrap-balloon (text "This is so much fun!") 'sw -5 3)
;               (cc-superimpose (blank 300 150) a-pict)
;               a-pict
;               rt-find)


(require pict/face)

;(face* 'none 'plain #t default-face-color 6)

;#lang web-server/insta
(define (start request)
  (response/xexpr
   '(html
     (head (title "Merve's Blog"))
     (body (h1 "Welcome to Merve's Blog!")))))

(struct post (title body))

(define BLOG (list (post "March 03, 2015"
                         "Hey, this is my first post!")))

* output from your code demonstrating what it produced
<br />There are several small pictures as the output such as this one: 

Your Web application is running at http://localhost:63182/servlets/standalone.rkt.
Stop this program at any time to terminate the Web Server.

Web Server stopped.




 
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.
