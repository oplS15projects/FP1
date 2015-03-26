# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: Web-Server

#### Narrative

I worked with the web-server library. I’m familiar with web, but I’m not familiar with using Scheme libraries to do web, so I thought that'd be a challenge. And yes, yes it was. It was challenging because I thought the API documentation was very poor. My code might not seem like much, but it actually took me an hour to figure out how to load a CSS file. The section on adding a CSS file was not clear at all. So much so that I went digging for an example. And the example didn’t really help either. I really just experimented and used the console as much as possible to isolate the problem. My wrongdoings were very subtle, and that didn't help. I felt like I was back at the beginning of the course again. I will have to re-wrap my head around another part of Scheme.

In addition to loading a CSS file, I experimented with inline styles, different types of tags (e.g. h1 and p), and forms. My form right now is just a next button and it redirects to another page. That also took me some time to understand because it wasn't clear to me that "send" statements should have both been in the define. In retrospect that seems silly, but this actually wasn't easy.

I really want to do something web related for the project, so it's likely I'll have to bite the bullet and learn to use this library.

#### Code
```
#lang racket

(require web-server/servlet
         web-server/servlet-env)

(define (start req)
  (send/suspend
   (lambda (k-url)
     (response/xexpr
      `(html (head (title "Enter a number")
                   (link ([rel "stylesheet"] [href "/style.css"])))
             (body [(style "background-color: #FFC0CB;")]
                   (h1 "Hello, World!")
                   (p "I'm writing my first web program in Scheme. Never did I think this day would come.")
                   (p "Hit next to continue.")
                   (form ([action, k-url])
                         (input ([type "submit"] [value "Next"]))))))))
  (send/finish
   (response/xexpr
    `(html (head (title "Test Program All Done")
                 (link ([rel "stylesheet"] [href "/style.css"])))
           (body [(style "background-color: #ADD8E6;")]
                 (h1 "So that's it!")
                 (p "Well, for now..."))))))
(serve/servlet start
               #:extra-files-paths
               (list
                (build-path "/Users/kaitlyncarcia/Desktop/") "htdocs"))
```

#### Output

![screenshot1](http://weblab.cs.uml.edu/~kcarcia/output1.png)

![screenshot2](http://weblab.cs.uml.edu/~kcarcia/output2.png)
