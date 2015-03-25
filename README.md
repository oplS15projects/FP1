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

### My Library: (racket/gui)

Write what you did!
Remember that this report must include:
 
* a narrative of what you did

I created a frame that includes a tab panel, a message, a button, a menu bar that contains menus and menu items, and a status bar. There are three tabs to the panels labeled as follow: Tab 1, Tab 2, and Tab 3. I created a callback for the tab-panel which check to see if the tab-selection is the first, second, or third tab and depending on which tab was selected, the status bar at the bottom of the frame will report out which tab is selected. The menu bar is at the top part of the frame and a status bar is at the bottom of the frame. There are four menus in the menu bar, file, edit, view, and language. Under each menu, there exists individual menu items. For example, when the user click on the file menu on the menu bar, a drop down with the list of menu items (New, Open, Exit) will show. I also implemented a message which is located under the tab-panel and the message says "Welcome". Lastly, I created a button under the message that does nothing at all.  

* the code that you wrote
```
#lang racket
(require racket/gui)

(define frame (new frame% [label "Example"] [width 500] [height 500]))
(define my-tab-list (list "Tab 1" "Tab 2" "Tab 3"))
(define tab-panel (new tab-panel% [choices my-tab-list] [parent frame]
                        [callback (lambda (tab-panel event)
                                    (cond ((= 0 (send tab-panel get-selection)) 
                                           (send frame set-status-text (string-append "You selected " (send tab-panel get-item-label (send tab-panel get-selection)))))
                                          ((= 1 (send tab-panel get-selection))
                                           (send frame set-status-text (string-append "You selected " (send tab-panel get-item-label (send tab-panel get-selection)))))
                                          (else (send frame set-status-text (string-append "You selected " (send tab-panel get-item-label (send tab-panel get-selection)))))
                                          ))]))

(define my-menu-bar% (new menu-bar% [parent frame]))
(define menu-list (list "File" "Edit" "View" "Language" "Racket"))
(define my-menu-bar-menu-file% (new menu% [parent my-menu-bar%] [label "&File"]))
(define my-menu-bar-menu-edit% (new menu% [parent my-menu-bar%] [label "&Edit"]))
(define my-menu-bar-menu-view% (new menu% [parent my-menu-bar%] [label "&View"]))
(define my-menu-bar-menu-language% (new menu% [parent my-menu-bar%] [label "Language"]))

(new menu-item% [parent my-menu-bar-menu-file%] [label "New"] [callback (lambda (item event) void)])
(new menu-item% [parent my-menu-bar-menu-file%] [label "Open"] [callback (lambda (item event) void)])
(new menu-item% [parent my-menu-bar-menu-file%] [label "Exit"] [callback (lambda (item event) void)])

(new menu-item% [parent my-menu-bar-menu-edit%] [label "Undo"] [help-string "To Undo something"] [callback (lambda (item event) void)])
(new menu-item% [parent my-menu-bar-menu-edit%] [label "Redo"] [help-string "To Redo something"] [callback (lambda (item event) void)])

(new menu-item% [parent my-menu-bar-menu-view%] [label "Decrease Font Size (To 9)"] [callback (lambda (item event) void)])
(new menu-item% [parent my-menu-bar-menu-view%] [label "Increase Font Size (To 11)"] [callback (lambda (item event) void)])

(new menu-item% [parent my-menu-bar-menu-language%] [label "Choose Language     Ctlr+L"] [callback (lambda (item event) void)])

; Make a static text message in the frame
(define msg (new message% [parent frame]
                          [label "Welcome"]))
 
; Make a button in the frame
(new button% [parent frame]
             [label "Nothing"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         void)])
 
(send frame create-status-line)
(send frame set-status-text (string-append "You are on " (send tab-panel get-item-label (send tab-panel get-selection))))
(send frame show #t)
```
* output from your code demonstrating what it produced
```
(object:menu-item% ...)
(object:menu-item% ...)
(object:menu-item% ...)
(object:menu-item% ...)
(object:menu-item% ...)
(object:menu-item% ...)
(object:menu-item% ...)
(object:menu-item% ...)
(object:button% ...)
```
* any diagrams or figures explaining your work 

<p align="center">
  <img src="http://s24.postimg.org/5zxf8pzx1/fp1_pic.png">
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
