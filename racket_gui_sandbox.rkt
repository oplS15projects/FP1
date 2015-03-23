#lang racket

(require racket/gui)

;;I used square brackets to denote fields getting values.

(define main-frame (new frame% [label "C->F Converter"]
                               [width 300]
                               [height 100]))

(define txt (new text-field% [label "Celsius:"]
                             [parent main-frame]))

(define msg (new message% [parent main-frame]
                          [auto-resize #t]
                          [label "Enter a temp in celsius in the text above."]))

(define btn (new button% [parent main-frame]
                         [label "Convert!"]
                         [callback (lambda (button event) (send msg 
                                                                set-label
                                                                (string-append "Fahrenheit: " (number->string (+ 32 (* 1.8 (string->number (send txt get-value))))) " degrees.")))]))


(send main-frame show #t)
