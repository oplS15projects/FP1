#lang racket/gui
;http://docs.racket-lang.org/gui/index.html
;http://docs.racket-lang.org/gui/windowing-overview.html

(require racket/gui/base)

(define main-window (new frame%
                         (label "Main Window")))

(define h-panel (new horizontal-panel%
                     (parent main-window)
                     (alignment '(left top))))

(define tf-filepath (new text-field%
                         (parent h-panel)
                         (label "Path")
                         (min-width 300)))

(new button%
     (parent h-panel)
     (label "Browse...")
     (callback (lambda (b e)
                 (define filepath (get-file))
                 (send tf-filepath set-value (path->string filepath)))))

(send main-window show #t)
