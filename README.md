# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: racket/gui
I decided to play around with the GUI library in Racket. I learned how to make a new window, how to make static messages within a new frame, how to create a new canvas within that frame, in addition to creating and modifying text within that canvas, how to create a button and provide it a callback procedure for button click, and how to display this entire system in a new window. 

I defined a new frame and modified its dimensions by the code below:

```
(define n-frame (new frame% [label "Aperture Science"]
                    		[width 650]
                     		[height 335]))
```

I created a static message by defining a new message, instantiating the message% class, assigning this new frame as the parent, and providing a string output as the label parameter in this new message definition. This is shown below: 

```
(define n-message 
  (new message% [parent n-frame]
                [label "Cake, and grief counseling, will be available at the conclusion of the test."]))
```

When a button is clicked, a new static message appears below. Below is the callback procedure:

```
[callback (lambda(button event)
                 (send n-message set-label "The cake is a lie. The cake is a lie. The cake is a lie."))])
```


The code that I wrote is on fp1.rkt. Most of the text content is from Valve's Portal, only because it's been an amusing ride playing this game. The text in the middle of the window are from the ending song, "Still Alive". I have two screenshots in this directory for reference, one for before a button click and another for after a button click. 
