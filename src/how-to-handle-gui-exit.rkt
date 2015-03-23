#lang racket

;http://stackoverflow.com/questions/18684412/how-to-handle-gui-exit-in-racket/18685869#18685869

;You can augment the (on-close) method to execute something when a window is closed.

(require racket/gui)

(define my-frame-class%
  (class frame%
    (super-new)
    (define/augment (on-close)
      (displayln "Exiting..."))))

(define my-frame (new my-frame-class%
                      (label "My Frame")
                      (width 400)
                      (height 200)))

(send my-frame show #t)