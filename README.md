# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### Program Code:
```
#lang racket
#lang racket/gui
(require racket/gui/base)

(define vis_frame (new frame% [label "Data Visualization Tool"]))
(define edit_frame (new frame% [label "Data Editor"] [width 300] [height 300]))

(define mb (new menu-bar% [parent vis_frame]))

(define m_file (new menu% [label "File"] [parent mb]))
(define m_help (new menu% [label "Help"] [parent mb]))

(new menu-item%
       [parent m_help]
       [label "About"]
       [callback (lambda (b e) (message-box "About" "This is an exploration!" vis_frame))])

(new menu-item%
       [parent m_help]
       [label "Contact"]
       [callback (lambda (b e) (message-box "Contact" "Contact Info: John Smith" vis_frame))])

(new menu-item%
       [parent m_file]
       [label "Load"]
       [callback (lambda (b e)  (send edit_frame show #t))])

(new menu-item%
       [parent m_file]
       [label "Save"]
       [callback (lambda (b e)  (send edit_frame show #f))])

(new menu-item%
       [parent m_file]
       [label "Exit"]
       [callback (lambda (b e)  (send vis_frame show #f))])

(new separator-menu-item% [parent m_file])

(define panel (new horizontal-panel% [parent vis_frame] [alignment '(center center)]))

(new button% [parent panel]
             [label "Load File"]
             [callback (lambda (button event)
                         (send edit_frame show #t))])

(new button% [parent panel]
             [label "Save File"]
             [callback (lambda (button event)
                         (send edit_frame show #f))])

(new button% [parent panel]
             [label "Exit"]
             [callback (lambda (button event)
                         (send vis_frame show #f))])

(define msg (new message% [parent vis_frame]
                          [label "Open a .rkt file containing a single list named lst"]))

(define edit_msg (new message% [parent edit_frame]
                          [label "This is the data editing window"]))

(send mb enable #t)
(send vis_frame show #t)
```

### My Library: Racket GUI Toolkit
### Narrative:
The code I wrote creates a two-frame program. The first frame is a simple loader with both a menu bar and a menu panel filled with buttons. This frame would be used to load a file containing data to be visualized and a way to save it when done. The second frame is the actual viewer and editor where a data structure wouled be represented graphically. A user would be able to modify the data structure and its contents in this window and then save the changes which would generate a new list in Racket.

### Program Output/Images:
https://drive.google.com/folderview?id=0B7j4TU2jQ5KxflNySlI4ODhaSnd1ajd3QWFSaTB3ZmpWeWFzbkdqSWxmenJ2SzY3Y1VkeG8&usp=sharing
