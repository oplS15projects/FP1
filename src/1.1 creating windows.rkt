#lang racket
;http://docs.racket-lang.org/gui/index.html

(require racket/gui/base)

(define main-window (new frame% (label "1.1 Creating Windows") (width 300) (height 300)))
(define msg (new message% (parent main-window)
                          (label "Hello, Yong")))
(new button% (parent main-window)
             (label "Click Me")
             ; Callback procedure for a button click:
             (callback (lambda (button event)
                         (send msg set-label "Button click"))))
; Derive a new canvas (a drawing window) class to handle events
(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse and keyboard events
    (define/override (on-event event)
      (send msg set-label "Canvas mouse"))
    (define/override (on-char event)
      (send msg set-label "Canvas keyboard"))
    ; Call the superclass init, passing on all init args
    (super-new)))
(new my-canvas% (parent main-window))
(new button% (parent main-window)
             (label "Pause")
             (callback (lambda (button event) (sleep 5))))

(define panel (new horizontal-panel% (parent main-window)))
(new button% (parent panel)
             (label "Left")
             (callback (lambda (button event)
                         (send msg set-label "Left click"))))
(new button% (parent panel)
             (label "Right")
             (callback (lambda (button event)
                         (send msg set-label "Right click"))))

(send main-window show #t)
