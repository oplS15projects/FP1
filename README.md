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

### My Library: racket/gui
I played around with buttons and adding a canvas that did nothing in a window. I observed the behavior of the event queue in racket and watched how the message loop operates. I added a blank canvas to see what resizing would do to teh window. It isn't apparent here but I ran the code under different desktop environments under a linux environment and on Windows 8 as well through drracket, to similar effects.

Some thoughts come to mind which make the idea of gui troubling to do with functional programming and GUIs. GUIS need mutable state and perfect functional programming cannot achieve this. Coming from a more haskell-y sandbox environment I understand that absolutely nothing gets done without mutable state and side effects so I suppose this is tangent is rather irrelevant.


code: 
#lang racket/gui

(require racket/gui/base)

(define frame (new frame% [label "Senpai Wolf's Window"]))

(define msg (new message% [parent frame] 
                 [label "Senpai didn't notice me :("]))

(new button% [parent frame]
     [label "please notice me senpai"]
     [callback [lambda (button event)
                 (send msg set-label "senpai noticed me :)")]])

(new button% [parent frame]
     [label "Come on and slam"]
     [callback [lambda (button event)
                 (send msg set-label "AND WELCOME TO THE JAM")]])

(send frame show #t)


(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-event event)
      (send msg set-label "Canvas mouse"))
    ; Define overriding method to handle keyboard events
    (define/override (on-char event)
      (send msg set-label "Canvas keyboard"))
    ; Call the superclass init, passing on all init args
    (super-new)))
 
; Make a canvas that handles events in the frame
(new my-canvas% [parent frame])

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
