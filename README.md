# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: racket/gui
Remember that this report must include:
 
* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work 
 
I decided to go with the basic GUI library that is included in racket. I figure that no matter what kind of program I decide to do, having a basic GUI will be important to the program. First I started by just copying and pasting the basic code from the tutorial. This looked something like this:
```
(define frame (new frame% [label "Example"]))
 
(define msg (new message% [parent frame]
                          [label "No events so far..."]))
 
(new button% [parent frame]
             [label "Click Me"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send msg set-label "Button click"))])
 
(send frame show #t)
```
After this, I started to dive deeper into the tutorial and was able to alter the window to have a few different buttons that did different things. The final window that I was able to produce had three buttons, Left, Close, and Right. Left and Right would echo that their respective button was clicked, while Close closed the window. The coee looked like this:

```
(define frame (new frame% (label "Final Project 1")))
 
(define msg (new message% (parent frame)
                          (label "Click a button.")))
 
(define panel (new horizontal-panel% (parent frame)))
(new button% (parent panel)
             (label "Left")
             (callback (lambda (button event)
                         (send msg set-label "Left click!"))))
(new button% (parent panel) 
     (label "Close")
     (callback (lambda (button event)
                         (send frame show #f))))
(new button% (parent panel)
             (label "Right")
             (callback (lambda (button event)
                         (send msg set-label "Right click!"))))

(send frame show #t)
```

The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

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
