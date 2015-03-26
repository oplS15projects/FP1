# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

Write your report right in this file. Instructions are below. You can delete them if you like, or just leave them at the bottom.
You are allowed to change/delete anything in this file to make it into your report. It will be public, FYI.

This file is formatted with the [**markdown** language][markdown], so take a glance at how that works.

This file IS your report for the assignment, including code and your story.

Kevin Ornellas
kevinseeker10

### My Library: Plot 
Write what you did!

Although I began with the plot library, I also spent some time trying out the card games library before going back to the plot library.

I started by reading part of the first section of the accompanying racket documentation, then modifying the given function from a sin function that went from negative pi to pi to a cosine function that went from zero to two pi.
The pertinent code is as follows:

(require plot)
(plot (function cos(- 0) (* 2 pi) #:label "y = cos(x)"))

which generated this image:
(http://s296.photobucket.com/user/kevinseeker10/media/cosgraph_zpsnt3bifqq.png.html)

After that, I then moved on to modifying the 3dplot of sin x * cos x graph, which I modified to ((sin x)^3) *( (cos x) ^3) and changed the period from -pi to pi to going from 0 to 2 * pi. The image for the code below is here:


(plot3d (surface3d (lambda (x y) (* (expt (cos x) 3) (expt (sin y) 3)))
                   (- 0) (* 2 pi) (- 0) (* 2 pi))
        #:title "My version of an R x R to R function"
        #:x-label "x" #:y-label "y" #:z-label "(cos x)^3 * (sin x) ^ 3")


I adjusted the title and afterward, I rotated the resulting plot. Because I had trouble seeing the image in Dr. Racket, I included the line (plot-new-window? #t) before the main block of code so that the graph would be depicted in a separate window, which made it easier to screenshot with Shutter. Later, I uploaded this to Photobucket.
(http://s296.photobucket.com/user/kevinseeker10/media/myver_rxr_to_r_function_zpsrp6vt1bf.png.html)


Continuing to follow the introduction in the racket documentation for plot, I followed the easier way of labeling the axes with a parameterize and the various names for the labels which I took from the racket documentation:
(
parameterize ([plot-title  "My version of an R x R to R function with colored contours"]
                 [plot-x-label "x"]
                 [plot-y-label "y"]
                 [plot-z-label "(cos x)^3 * (sin x)^3"])
                 ...
                 
  and the more code to come depicted the same graph that I had made before except in color to highlight the contours, which is accomplished by the code:
  (plot3d (contour-intervals3d (lambda (x y) (* (expt (cos x) 3) (expt (sin y) 3)))
                   (- 0) (* 2 pi) (- 0) (* 2 pi))))



(http://s296.photobucket.com/user/kevinseeker10/media/colored_contours_zpsgaugw52r.png.html)

Going along with the racket documentation, I created a graph that held multiple two dimensional graphs, this time with y= x * sin x and dotted lines of different shades of blue at y = x and y = -x which demarcated it's upper and lower bounds.

; melded with code from racket doc


(plot (list (axes)
            (function (lambda (x) (* x (sin x))) 0 (* 8 pi) #:label "y = x * sin x")
            (function (lambda (x) x) #:color 0 #:style 'dot #:label "y = x")
            (function (lambda (x) (- x)) #:color "blue" #:style 'dot #:label "y = - x")))

The 3 graphs on the same plot are available here: (http://s296.photobucket.com/user/kevinseeker10/media/xsinx_bound_graph_zpsyqnco63a.png.html)

I then proceeded to read the beginning of GUI plotting procedures. I hope you enjoyed looking at my narrative.


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
