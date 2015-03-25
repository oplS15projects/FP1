# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

It is my first work on github
And the first problem I met is how to deal with markdown language。

This file is formatted with the [**markdown** language][markdown].

This file IS my report for the assignment, including code and my story.

Code is super easy in markdown, which I can easily do inline `(require web-server/servlet)` or do in whole blocks:
```
#lang racket

(require web-server/servlet)
(require web-server/servlet-env)

 (define (my-web request)
    (response/xexpr
     '(html (head (title "My OPL Website"))
            (body
              (h1 "This is a Title")
              (p "This is a paragraph") ) )
  ))
 
(serve/servlet my-web)
```

### My Library: (Web servlets)


In this assignment, professor asks us to test one lib in racket which we are interested in. It is really cost my time to pick
one. Finally, I choose the library "web-server/web-servlet-env" to make a simple website. Because I just learn how it works 
by HTML file. I found that is as easy as in racket. we just need do inline (require web-server/servlet 
web-server/servlet-env). After that we need use X-expressions (xexpr) to create some lists in my website. Then, it become 
like [MyWeb][mphoto].



<!-- Links -->
[mphoto]: http://i.imgur.com/hDIPdu8.jpg
[piazza]: https://piazza.com/class/i55is8xqqwhmr?cid=411
[markdown]: https://help.github.com/articles/markdown-basics/
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
