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

### My Library: (library name here)
Write what you did!
Remember that this report must include:
 
* a narrative of what you did
The very first thing I did was look though all the libraries to decide which one I wanted to work with. I played with a couple and decided to go with the math library for the first library I wanted to work with. I went through all the existing procedures that it had and was thinking about how to apply these functions. I thought about what formulas I knew that could work with the existing functions.
* the code that you wrote
#lang racket

(require math)

;determines how far are you from a random number 0-100
(define (far-off x)
  (absolute-error (random-natural 100) x))

;determines how far you are off from 50
(define (from-fifty x)
  (absolute-error 50 x))


;determines the chance of getting a certain number of heads
;in a row with a specific number of flips
(define (chance-heads flips heads)
  (* (/ (/ (factorial flips)
     (* (factorial heads) (factorial (- flips heads))))
     (expt 2.0 flips)) 100))

;chance of getting at LEAST the number of heads in a specific number of flips
(define (chance flips heads)
  (if (= flips heads)
      1
      (+ (* (/ (/ (factorial flips)
                  (* (factorial heads) (factorial (- flips heads))))
               (expt 2.0 flips)) 100)
         (chance flips (+ heads 1)))))


;;matrix multiplication
(define A (matrix [[1 2 3] [4 5 6]]))
(define B (matrix [[7 8] [9 10] [11 12]]))
(matrix* A B)
  

* output from your code demonstrating what it produced
(array #[#[58 64] #[139 154]])
> (far-off 5)
56
> (from-fifty 30)
20
> (chance-heads 10 4)
20.5078125
> (chance 10 8)
6.37109375
* any diagrams or figures explaining your work 

<p align="center">
  <img src="/http://s27.postimg.org/92uu914yb/prob.png"/>
</p>

<p align="center">
  <img src="/http://s3.postimg.org/obc6jrm0j/image.png"/>
</p>
 
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.

### How to Do and Submit this assignment

1. To start, [**fork** this repository][forking].
1. You might want to [**Clone**][ref-clone] this repository to your computer
  2. (This assignment is just one README.md file, so you can edit it right in github without cloning if you like)
1. Modify the README.md file and [**commit**][ref-commit] changes to complete your solution.
1. [**Push**][ref-push]/sync the changes up to your GitHub (skip this if you didn't clone)
1. [Create a **pull request**][pull-request] on the original repository to turn in the assignment.

<!-- Links -->
[piazza]: https://piazza.com/class/i55is8xqqwhmr?cid=411
[markdown]: https://help.github.com/articles/markdown-basics/
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
