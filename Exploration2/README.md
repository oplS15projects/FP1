Final Project Assignment 1: Exploration (FP1)
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is on Piazza.

Write your report right in this file. Instructions are below. You can delete them if you like, or just leave them at the bottom. You are allowed to change/delete anything in this file to make it into your report. It will be public, FYI.

This file is formatted with the markdown language, so take a glance at how that works.

This file IS your report for the assignment, including code and your story.

Code is super easy in markdown, which you can easily do inline (require net/url) or do in whole blocks:

#lang racket

(require net/url)

(define myurl (string->url "http://www.cs.uml.edu/"))
(define myport (get-pure-port myurl))
(display-pure-port myport)
My Library: (library name here)

Write what you did! Remember that this report must include:

a narrative of what you did
the code that you wrote
output from your code demonstrating what it produced
any diagrams or figures explaining your work
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.

How to Do and Submit this assignment

To start, fork this repository.
You might want to Clone this repository to your computer
(This assignment is just one README.md file, so you can edit it right in github without cloning if you like)
Modify the README.md file and commit changes to complete your solution.
Push/sync the changes up to your GitHub (skip this if you didn't clone)
Create a pull request on the original repository to turn in the assignment.

: write up:
For the second exploration I had the idea of parsing HTML from an existing site and hosting it remotely from racket. Well, I guess this was a good idea to try, but I did not successfully meet my goal, yet. The biggest problem I encountered while looking into the parsing of the HTML, is that the HTML library does not really provide any useful tools to converting it to x-expression. I then went to Google for some help and I found some promising code among others that said it the code would do what I needed, but it was slightly wrong. I first used read-html-as-xml to convert the code to XML to then convert to x-expression. This seemed promising and correct but when I Went to launch the code for the web server it looked like it only converted the head to proper x-expression. I then tried another conversion from the HTML library called html->xexpr, but again the results where not as expected. I have come to the conclusion right now that if I want to generate proper x-expression code to essentially imitate a page I need to read the HTML as plain text and parse it myself to convert it to a proper x-expression. This is something that I realized today after trying to make the XML/HTML libraries do what I want. Unfortunately, I don't think I can finish creating a custom HTML to x-expression parser for this exploration, but it is something I would like to integrate for the final project. I could use the knowledge I learned from this exploration to build a custom editor for HTML that allows you to test easily while developing or something with GUI. I viewed this exploration to be insightful and motivating. For this exploration I also looked into net/url, web-server/servlet, web-server/servlet-env, XML/HTML, and the brief exploration of and external library called planet neil/html-parsing:2:0 to test to see if it would parse it the way I wanted it to be parsed.

Code:

#lang racket
;to host a racket webserver
(require web-server/servlet
         web-server/servlet-env
         ;parser for html
         html
         ;parser for xml
         xml
         ;get the url page content
         net/url
         ;prefix for html and xml (since syntax cn be confused within racket)
         (prefix-in h: html)
         (prefix-in x: xml)
         ;because the built in racket was garbage
         (planet neil/html-parsing:2:0))

;determines if the path for the file is windows or unix
(file-url-path-convention-type)

;readable url for ports 
(define in-val (string->url "https://www.google.com/"))
(define in-val1 (string->url "https://www.outdoored.com/jobs/summer-kayak-internship"))
(define footest (string->url "http://localhost:8080/foo/testing"))
(define xtest (path->url "C://Users//Emmy//Desktop//UML//newhtmltest.html"))
;(define in-path (relative-path->relative-url-string "C:\Users\Emmy\Desktop\UML\newhtmltest.html"))

;got this from
;http://stackoverflow.com/questions/28195841/how-to-extract-element-from-html-in-racket
;I found it seemingly difficult to use the html struct variables
;this doesnt even work as intended
;(define (read-html-as-xexpr in) ;since the value we want is contained in th 3rd values location
;   (caddr (xml->xexpr
;    (element #f #f 'root '() ;creates an element that has a root and '(), required cast
;             (read-html-as-xml in)))))

;;closes port after information is extracted
(define (read-url-port in)
  (call/input-url in ;the url
                  get-pure-port ;port for first var
                  read-html));function to be applied

   
        
;dynamically creates the response/xexpr for the host,
;with a passed xexpression
;variable to just test for now
;(define (port_to_string val) (port->lines (get-pure-port val)))
;(define test_pts (port_to_string in-val))
;(define (make_prety var prev_char cur_token new_l)
;  (if(equal? null prev_char)
;     (cond((equal? prev_char null) 
           ;(make_prety 
            ;(substring var (- (string-length var) 1)) 
           ; (string-ref var 0)
         ;;   (string-append cur_token (string-ref var 0))
        ;    new_l))
      ;;    ((equal? prev_char #\
     ;     ((equal? (string-ref var 0) #\>)
    ;       (make_prety
   ;         (substring var (- (string-length var) 1))
  ;          null
 ;           null
;            (append new_l (list (string-append cur_token ">")))))
;          ((equal? (string-ref var 0) #\<)
;           (display "error"))
;          (else
;           (make_prety
;            (substring var (- (string-length var) 1))
;            prev_char
            
          ;((equal? (string-ref var 0) #\>) (make pretty (substring var          (make_prety (substring var 1 (- (string-length var) 1)) prev_char new_l))
;     (if (equal?

;creates a value in xexpr for create a response/xexpr
(define to_create_val (read-url-port in-val))



;test planet neil package to rest of html
(define testneil (call/input-url
                   in-val
                   get-pure-port 
                   html->xexp))

;create a the xexpr to host the server for the test val
(define (create-response-xexpr req)
    (response/xexpr
     to_create_val))

;hosts the webserver with the passesexpression
(define (host-server read-port)
      (serve/servlet read-port))

;this last bit of code is something I am tying that simply reads and html and
;creates a list withall of its pcdata for content oftags.
  (define an-html
    (h:read-xhtml
     (open-input-string
      (string-append
       "<html><head><title>My title</title></head><body>"
       "<p>Hello world</p><p><b>Testing</b>!</p>"
       "</body></html>"))))
 
  ; extract-pcdata: html-content/c -> (listof string)
  ; Pulls out the pcdata strings from some-content.
  (define (extract-pcdata some-content)
    (cond [(x:pcdata? some-content)
           (list (x:pcdata-string some-content))]
          [(x:entity? some-content)
           (list (x:entity-text some-content))]
          [else
           (extract-pcdata-from-element some-content)]))
 
  ; extract-pcdata-from-element: html-element -> (listof string)
  ; Pulls out the pcdata strings from an-html-element.
  (define (extract-pcdata-from-element an-html-element)
    (match an-html-element
      [(struct h:html-full (attributes content))
       (apply append (map extract-pcdata content))]
 
      [(struct h:html-element (attributes))
       (apply append (map extract-pcdata attributes))]))

(printf "~s\n" (extract-pcdata an-html))
