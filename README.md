# Final Project Assignment 1: Exploration (FP1)

### My Library: plot (and, incidentally, math)

I was particularly interested in the different renderers offered by the plot library, so I decided to test drive a few of them. My simple test code follows:

```
#lang racket

(require plot)
(require math/base)
(require (only-in plot/utils linear-seq))

(define (logifun x)
  (/ 1 (+ 1 (expt euler.0 (- x)))))

(plot (function logifun (- 6) 6 #:label "y = L(x)"))
```
*Note: Also included are the basic math library for Euler's number, as well as the linear-seq sampling utility to help with the histogram.*

First, I tried the simple real function plot renderer, which simply plots a supplied function over a supplied range of inputs. I handed it the standard logistic curve, with the following results:  
![Logistic Curve Output](http://i.imgur.com/EQPywgg.png)  

Next, I extended this example by giving plot a list of renderers (here, only two) to show the curve as well as an approximation of the area under it:
```
(plot (list (area-histogram logifun (linear-seq -6 6 12))
            (function logifun -6 6 #:label "Area under y = L(x)")))
```
Which yields the following plot:
![Histogram Output](http://i.imgur.com/1gBHG5e.png)

The histogram renderer is of particular value, as it could be used in conjunction with other libraries, a sound-related one for example, to provide instantaneous or perhaps real-time analysis of data attributes such as frequency distribution in the case of audio.

### My Library: (library name here)
Write what you did!
Remember that this report must include:

* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work

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
