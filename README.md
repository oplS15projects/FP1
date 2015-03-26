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
 
* **a narrative of what you did**
  * I had a really hard time trying to figure out what to do with this project or exploring any options because I am honestly dislike writing scheme.  But I did find out from a friend that racket can be used as a server type program so I looked into options. I'm not sure what libraries it uses but he did mention something about xrepl and /server or /tcp stuff.  I do want to look into writing something that could host a web page of some sort so I looked up some ideas and i found the racket documentation actually had a small tutorial on how to do this [Link here](http://docs.racket-lang.org/more/index.html).  I tried editing some code to see how it works and so far I kept getting errors so I'm just giving you what I had up until now and will want to look into it further as days go by.  I basically tried to edit the code after doing some step by step writing and I will want to explore what each thing does (later on) (like tcp, listener, port-no, regexp-match).  I couldn't figure out how to actually make my machine host the code with drRacket so I downloaded and installed racket, did what it told me to do (install *or try to* xrepl) and then fired it up and ran (enter! "1.rkt") then (serve 8080). What I can assume is that it used the code from 1.rkt and use that code to serve port 8080 on my machine/network to host a wannabe website. And that stops right here as I am writing this narrative.
* **the code that you wrote**
![alt text](https://github.com/lqtran/FP1/blob/master/code.JPG "Code written")
* **output from your code demonstrating what it produced**
![alt text](https://github.com/lqtran/FP1/blob/master/SS.JPG "Product")
* **any diagrams or figures explaining your work** 
 
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
