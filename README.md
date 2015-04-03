I plan to do a small scheme game with my partner. It might use the gui part, so in final project exploration#1, I focus on the libraries about graphic user interface.I explored the library racekt/gui.  The first thing of building GUI is to crate Windows and drawing in canvases. I choose the library: gui/base and framework from http://docs.racket-lang.org/.. This program creates a frame with a text message and a button, when the user clicks the button, the message changes.  I add an event callback procedure to continue after click “ok” button. 

When running the code. It would come out a window called LOGIN. (picture1). Users can type his ID and password, then click OK. There appears a new window called information. (picture2). This window is consider as a container for users’ information. Then minimize the window, back to the LOGIN window, user can get a “quit” window after close the LOGIN window.(picture3). 

![picture 3](http://www.cs.uml.edu/~yliuchen/picture3.png)

Code:  
```racket
#lang racket 

(require racket/gui/base) 

(require framework) 

(define frame (new frame% 

                   [label "INFORMATION"] 

                   [width  600] 

                   [height 300])) ; Make a frame by instantiating the frame% class 

 (define dialog (instantiate dialog% ("LOGIN"))); Add a text field to the dialog 

 (new text-field% [parent dialog] [label "ID"]) 

  (new text-field% [parent dialog] [label "PASSWORD"]) 

 (define panel (new horizontal-panel% [parent dialog]  

 [alignment '(center center)])) ; Add a horizontal panel to the dialog 

(new button% [parent panel] [label "Ok"][callback (lambda (button event) 

                         (send frame show #t))]) ; Add Ok button to the horizontal panel 

(when (system-position-ok-before-cancel?) 

(send panel change-children reverse)) 

(send dialog show #t); Show the dialog 

(new canvas% [parent frame] 

             [paint-callback 

              (lambda (canvas dc) 

                (send dc set-scale 3 3) 

                (send dc set-text-foreground "black") 

                (send dc draw-text "Quit!" 0 0))]) (send frame show #t); Show the frame. 
                ```
                
                
                
             
