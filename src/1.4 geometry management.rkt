#lang racket
;http://docs.racket-lang.org/gui/index.html
;http://docs.racket-lang.org/gui/windowing-overview.html

;1.4 Geometry management
(require racket/gui/base)

; Create a dialog
;(define dialog (new dialog% (label "1.4 Geometry Management")))
(define dialog (instantiate dialog% ("1.4 Geometry Management")))

; Add a text field to the dialog
(new text-field%
     (parent dialog)
     (label "Your name"))

; Add a horizontal panel to the dialog, with centering for buttons
(define h-panel (new horizontal-panel%
                   (parent dialog)
                   (alignment '(center center))))

; Add Cancel and Ok buttons to the horizontal panel
(new button% (parent h-panel) (label "Cancel"))
(new button% (parent h-panel) (label "Ok"))
(when (system-position-ok-before-cancel?)
  (send h-panel change-children reverse))

(send dialog show #t)