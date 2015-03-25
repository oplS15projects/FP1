# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)
```
#lang racket

(require net/url)

(define myurl (string->url "http://www.cs.uml.edu/"))
(define myport (get-pure-port myurl))
(display-pure-port myport)
```

### My Library: (Browser)
The first thing is inorder for us to use this library is we need this line of code:
 (require browser)
Browser library is used for playing with HTML files like viewing and parsing them. There are various aspects that can be done by browser library like:

1. Opening a Web page((open-url url)
where url is a string, for ex ("http://www.cs.uml.edu")

2. getting a URL

3. getting a title((send a-hyper-text get-title)) which is used for getting a title of a webpage. For instance http://www.cs.uml.edu has a title of Computer Science.

4. We can also set a title of a web page by:(send a-hyper-text set-title str)which takes a string parameter.

5. we can also add, find, delete tags. Tags are the building block of HTML, because web page is built of various tags. In order for us to find a tag we can use:(send a-hyper-text find-tag name/number)

6. add a tag:(send a-hyper-text add-tag name pos) → void?
  which takes a string and  exact-nonnegative-integer.

7. Hyper link, because with hyper link we can have links to other web sites. we can create hyper links in a web page by:
 (send a-hyper-text add-link start end url) which takes
  start : exact-nonnegative-integer
  end : exact-nonnegative-integer
  url :  string

8. Reload functionality in scheme by: (send a-hyper-text reload)
which reloads the page.

9. Remap URL based on post data, (send a-hyper-text post-url	 	url [post-data-bytes])	 
 It gives more options on remap based on post data.

10. Redirect a user to a different web page we can use this function when redirecting a user(send a-hyper-text remap-url url)    : it takes a string as a parameter.

These are only few features of Browser library in scheme, there are lot of useful methods available to be used. Overall with this assignment I came to understand how to use scheme in the web.

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
