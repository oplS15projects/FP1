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
![Logistic Curve Output](https://github.com/pwelby/FP1/blob/master/BsPyqGX.png?raw=true)  

Next, I extended this example by giving plot a list of renderers (here, only two) to show the curve as well as an approximation of the area under it:
```
(plot (list (area-histogram logifun (linear-seq -6 6 12))
            (function logifun -6 6 #:label "Area under y = L(x)")))
```
Which yields the following plot:  
![Histogram Output](https://github.com/pwelby/FP1/blob/master/1gBHG5e.png?raw=true)

The histogram renderer is of particular value, as it could be used in conjunction with other libraries, a sound-related one for example, to provide instantaneous or perhaps real-time visualization of data attributes like frequency distribution in the case of audio.

Before moving on to the 3-dimensional plotting capabilities of the plot library, I decided to make a parametric Lissajous figure, as follows:
```
(plot (parametric (lambda (t) (vector (sin (* 4 t)) (cos (* 3 t)))) 0 (* 2 pi)))
```
![Lissajous Figure](https://github.com/pwelby/FP1/blob/master/E20NuMx.png?raw=true)  

Finally, I wanted to check out the surface renderer, and made the following surface (a bivariate Gaussian distribution):
```
(plot3d (surface3d (lambda (x y) (expt 3
                                       (- (+ (/ (* x x) 2)
                                             (/ (* y y) 2)))))
                   -3 3 -3 3))
```
![Bivariate Gaussian Surface](https://github.com/pwelby/FP1/blob/master/c2Oe92a.png?raw=true)  
