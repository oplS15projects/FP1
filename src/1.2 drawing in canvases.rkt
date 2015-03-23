#lang racket/gui
;http://docs.racket-lang.org/gui/index.html

(require racket/gui/base)

(define main-window (new frame%
                         (label "1.2 Drawing in Canvases")
                         (width 300)
                         (height 300)))
(new canvas%
     (parent main-window)
     (style '(transparent))
     (paint-callback
      (lambda (canvas dc)
        (send dc set-scale 3 3)
        (send dc set-text-foreground "blue")
        (send dc draw-text "Don't Panic!" 0 0))))

(send main-window show #t)
