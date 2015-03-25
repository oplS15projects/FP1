# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

Write your report right in this file. Instructions are below. You can delete them if you like, or just leave them at the bottom.
You are allowed to change/delete anything in this file to make it into your report. It will be public, FYI.

This file is formatted with the [**markdown** language][markdown], so take a glance at how that works.

This file IS your report for the assignment, including code and your story.

Code is super easy in markdown, which you can easily do inline `(require net/url)` or do in whole blocks:
```


### My Library: (SMTP: sending E-mail)
In Racket Documentation I have selected smtp sending E-mail library and I go through all the stuff gave in the library and it is quite similar way of sending an E-mail but we have to use some commands to implement in racket environment below are the commands

(require net/smtp):The net/smtp module provides tools for sending electronic mail messages using SMTP. 
we have to give (smtp-send-message	) to send message 

(server-address :) this Connects to the server at server-address and port-no to send a message. this will include from: which tell us where the mail came from and To: tells us where to send mail.

header: The header argument is the complete message header. A header is represented as a string or byte string containing CRLF-delimited lines. In addition, the header ends with two CRLFs 

message: The message argument is the body of the message, where each string or byte string in the list corresponds to a single line of message text.

port no:The  port-no argument—which can be specified either with the #:port-no keyword.

username : is the keyword used to add a username.
password: is used to give a password

tcp-connect: is used to connect as a client to a listing server.

 
the output I got like I got a new window opened and i got some errors like should enter auth-user, auth-password and after I cleared the errors  it gave me username and password to enter   
 
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
