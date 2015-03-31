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