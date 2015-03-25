# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)


### My Library: The Racket Graphical Interface Toolkit
 
* a narrative of what you did

I explored the Racket Graphical Interface Toolkit for my assignment. While I plan to use a number of other libraries I felt this library contained core necessities. I started out exploring creating the window in general. While it is not a major feature, I find small things like opening in the center of the monitor to be important. I then continued on to try and create a couple different items from what is available. The window I created contains a message, an image, a button, a checkbox, a choice list, a gauge, a drop list and a text area. Each of these items has a number of options. I also looked into the other objects available and what options they contained.

I enjoyed creating the little callbacks for feedback on the objects. The button that says “Click Me” will change the interactions message to display the number of times the button has been clicked. The checkbox, choice list, and drop list will change the interactions message to say what the selected value is. When the “Increase Gauge” button is clicked, the gauge will update. The gauge will fill to 100 clicks and then reset to zero. I decided not to implement a callback for the text area. 

The image was the last item I worked on and it caused a number of issues for me. I was able to get it working in the end though. It required the creation of a canvas and a bitmap object. The canvas has a component called dc, which is a key part that I was missing at first. The dc itself has the draw-bitmap procedure which adds the image to the canvas. The canvas was added to the frame to display the image. At first, I thought it was still not working because I almost missed the sliver of my image at the bottom of the canvas. The positioning of the image was off because the canvas was too small for the image. Once it was larger, the image came into view properly.


* the code that you wrote

```
#lang racket
(require racket/gui/base)

(define-values (screen-width screen-height) (get-display-size))
(define-values (frame-width frame-height) (values 400 600))
(define pos-x (- (/ screen-width 2) (/ frame-width 2)))
(define pos-y (- (/ screen-height 2) (/ frame-height 2)))

(define frame (new frame% 
                   (label "MyWindow")
                   (width frame-width)
                   (height frame-height)
                   (x pos-x)
                   (y pos-y)))

(define greeting (new message% 
                      (parent frame)
                      (label "Experiment with some GUI items")))

(define msg (new message% 
                 (parent frame)
                 (label "No Interactions")
                 (auto-resize #t)))

(define image (make-object bitmap%	 
                "smile.png"	 
                'png	 
                #f	 
                #t	 
                1.0))

(define canvas 
  (new canvas%
       (parent frame)
       (min-width (send image get-width))
       (stretchable-width #f)
       (min-height (send image get-height))
       (stretchable-height #f)
       (paint-callback (lambda (canvas dc)
                         (send dc draw-bitmap image 0 0 )))))



(define button-clicks 0) 
(define buttton 
  (new button% 
       (parent frame)
       (label "Click Me")
       (callback (lambda (button event)
                   (set! button-clicks (+ 1 button-clicks))
                   (send msg set-label 
                         (format "Button clicks: ~a" button-clicks))))))


(define check-box 
  (new check-box%
       (parent frame)
       (label "Check Box")
       (value #f)
       (callback (lambda (check-box event)
                   (send msg set-label 
                         (format "Checkbox is now: ~a" 
                                 (send check-box get-value)))))))

(define choices1 
  (list "Apples" "Oranges" "Bananas" "Grapes" "Peaches" "Lemons"))
(define choices 
  (new choice%
       (label "Choice List ")
       (parent frame)
       (choices choices1)
       (callback (lambda (choice event)
                   (send msg set-label 
                         (format "Choice list is now: ~a" 
                                 (send choice get-string-selection)))))))

(define buttton2 
  (new button% 
       (parent frame)
       (label "Increase Gauge")
       (callback (lambda (button event)
                   (send gauge set-value 
                         (modulo (+ 1 (send gauge get-value)) 100))))))

(define gauge 
  (new gauge%
       (label "Click to fill ")
       (parent frame)
       (range 100)))


(define choices2 
  (list "Red" "Orange" "Yellow" "Green" "Blue" "Indigo" "Violet"))
(define droplist 
  (new combo-field%
       (label "Drop List")
       (parent frame)
       (choices choices2)
       (init-value "Please type or select a value")
       (callback (lambda (combo-field event)
                   (send msg set-label 
                         (format "Drop list is now: ~a" 
                                 (send combo-field get-value)))))))

(define editor-canvas (new editor-canvas%
                           (parent frame)
                           (label "Editor Canvas")))
(define text (new text%))
(send text insert "Text Area...")
(send editor-canvas set-editor text)

(send frame show #t)
(send canvas show #t)
```

* output from your code demonstrating what it produced
![Code Output](https://cloud.githubusercontent.com/assets/11641731/6818542/0318f152-d288-11e4-9b64-db22d9610acb.png)
 
