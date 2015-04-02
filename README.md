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
[html-parsing]: http://docs.racket-lang.org/html/index.html
[facebook feed]: http://www.forbes.com/sites/roberthof/2015/03/25/a-peek-inside-how-facebook-decides-what-goes-into-your-news-feed/
### Worked on HTML parsing library

The library that i looked at can be found [**Html-parsing**][html-parsing] 
In this library i played with how it goes through each tag it finds and reads the information between the 
opening tag "html" to the closing tag "/html" and prints out the information having removed the tags and just 
left the data/ value between the tags. For this to work the tags have to be inbuilt in HTML or it will ignor the tag that it does not recognize and look over it while parsing. i put in a tag "me"opening and closing tags "/me" which the content was ignored by the parsor and was not printed out. This tag can be handled by an Xml parsor .
I edited a html file added afew lines to it. Used a face book feed as part of the presentation.
[**facebook feed**][facebook feed]  from forbes and inlcuded it on the page layout of the html. 

The Code that i used is shown below.
```
#lang racket
;Norman Mutunga
;Testing the Html Parsor.
(require html)

(module html-example racket
  
  ; Some of the symbols in html and xml conflict with
  ; each other and with racket/base language, so we prefix
  ; to avoid namespace conflict.
  (require (prefix-in h: html)
           (prefix-in x: xml))
  
  (define an-html
    (h:read-xhtml
     (open-input-string
      (string-append
       "<html><head><title>HTML Title</title></head><body>"
       "<p> This would be a Html parsor OUT PUT ------>> </p> " 
       " <p> There’s nothing more central to Facebook, literally, than its news feed, the middle column of posted stories from friends and business connections, or on the smartphone, the only column. Besides serving as the key place where ads run, it’s what makes people keep coming back to Facebook–though all too often they wonder why the heck they got this viral video post when their sister’s post got lost in the scrolling depths. </p>"
       "<me> what can you see??? Nothing </me>"
       "</body></html>"))))
  
  ; extract-pcdata: html-content/c -> (listof string)
  ; Pulls out the pcdata strings from some-content.
  (define (extract-pcdata some-content)
    (cond [(x:pcdata? some-content)
           (list (x:pcdata-string some-content))]
          [(x:entity? some-content)
           (list)]
          [else
           (extract-pcdata-from-element some-content)]))
  
  ; extract-pcdata-from-element: html-element -> (listof string)
  ; Pulls out the pcdata strings from an-html-element.
  (define (extract-pcdata-from-element an-html-element)
    (match an-html-element
      [(struct h:html-full (attributes content))
       (apply append (map extract-pcdata content))]
      
      [(struct h:html-element (attributes))
       '()]))
  
  (printf "~s\n" (extract-pcdata an-html)))
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
(require 'html-example)
```
The output from the code below ;
```
("HTML Title" " This would be a Html parsor OUT PUT ------>> " "  " " There’s nothing more central to Facebook, literally, than its news feed, the middle column of posted stories from friends and business connections, or on the smartphone, the only column. Besides serving as the key place where ads run, it’s what makes people keep coming back to Facebook–though all too often they wonder why the heck they got this viral video post when their sister’s post got lost in the scrolling depths. ")

```
