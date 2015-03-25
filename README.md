# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Name: Jerra Khorn

### My Library: [The Racket Graphical Interface Toolkit](http://docs.racket-lang.org/gui/index.html)

`(require racket/gui)`

I didn't know which library I should invest my time in because I didn't really know what my final project would be.
Since I like games, why not do that. I decided to look into The Racket Graphical Interface Toolkit because
I thinking leaning towards making a text-base decision game; a sort of RPG decision game where the player can
choose an option which would change the way the game progressed.

I went through the basic example, seeing how they worked and how they looked like when executed.

This line created a window with the label "New Frame" on the top.

`(define frame (new frame% [label "New Frame"]))`

From then on, I could make text within the frame.
```
(define msg (new message% [parent frame]
                 [label "Hello World"]))
```

I progessed to creating buttons, that when clicked, performed some action.

```
(new button% [parent frame]
     [label "Click Me"]
     [callback (lambda (button event)
                 (send msg set-label "Button Clicked"))])
 ```
 
 When the button is clicked, the message in the frame that was labeled "Hello World" changes
 to "Button Clicked".
 
 [Before Clicked](http://i.imgur.com/I5vQrfI.png)
 
 [After Clicked](http://i.imgur.com/INmUtNG.png)
 
 To show the actually frame, I used this line to pop up the new window.
 
 `(send frame show #t)`
 
 Looking at one of the examples on the racket documentation, I could also make dialog boxes where the user could type in.
 
 ```
(define dialog (instantiate dialog% ("Character Creation")))
(new text-field% [parent dialog]
     [label "Your Name"])
(define panel (new horizontal-panel% [parent dialog]
                   [alignment '(center center)]))
(new button% [parent panel]
     [label "Cancel"])
(new button% [parent panel]
     [label "Create"])

(send dialog show #t)
 ```
 
 [Dialog Box Output](http://i.imgur.com/MUnylwj.png)
 
 But in this example, clicking the buttons do not do anything.
 I was thinking here is a good place to start having the user create a character for the game.
 
