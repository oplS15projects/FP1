# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: racket/draw and also racket/gui/base
Write what you did!
Remember that this report must include:
 
* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work 
 
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.



```
#lang racket

(require net/url)

(define myurl (string->url "http://www.cs.uml.edu/"))
(define myport (get-pure-port myurl))
(display-pure-port myport)
```

![](/images/firstpart1.png)
