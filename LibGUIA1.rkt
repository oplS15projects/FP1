(require racket/gui)

; Make a frame by instantiating the frame% class
(define frame (new frame% [label "Example"]
                   [width 300]
                   [height 300]))
;pop up frame
(define frame2 (new frame% [label "popup"]
                    [width 200]
                    [height 200]))
(define msg2 (new message% [parent frame2]
                  [label "Jonathan Wydola"]))
; Make a static text message in the frame
(define msg (new message% [parent frame]
                          [label "No events so far..."]))

(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-event event)
      (send msg set-label "Canvas mouse"))
    ; Define overriding method to handle keyboard events
    (define/override (on-char event)
      (send msg set-label "Canvas keyboard"))
    ; Call the superclass init, passing on all init args
    (super-new)))
 
; Make a canvas that handles events in the frame
(new my-canvas% [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send dc set-scale 10 10))])

;creates a button that gives me credit
(define new_pan (new horizontal-panel% [parent frame]))
(new button% [parent new_pan]
     [label "credits"]
     [callback (lambda (button event) 
                 (send frame2 show #t))])
;just testing out a combo box
(new combo-field% [label "Combo Box"]
                [choices '("winning" "Losing")]
                [parent frame]
                [init-value "winning"])
                
;(new button% [parent new_pan]
;     [label "exit"])
     
; Show the frame by calling its show method
(send frame show #t)
