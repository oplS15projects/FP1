#lang racket/gui
;http://docs.racket-lang.org/gui/windowing-overview.html#%28part._.Creating_.Windows%29
;http://docs.racket-lang.org/gui/editor-overview.html

(require racket/gui/base)

(define main-window (new frame%
                         (label "Append-only Text")
                         (width 300)
                         (height 300)))

(define ec (new editor-canvas% (parent main-window)))

(define append-only-text%
  (class text%
    (inherit last-position)
    ; augment is a way to override a superclass function.
    ; this function can be called by the superclass.
    (define/augment (can-insert? s l) (= s (last-position)))
    (define/augment (can-delete? s l) #f)
    ; super-new invokes superclass initialization
    (super-new)))

;(define t (new text%))
(define t (new append-only-text%))
(send ec set-editor t)

(define mb (new menu-bar% (parent main-window)))
(define m-edit (new menu% (label "Edit") (parent mb)))
(define m-font (new menu% (label "Font") (parent mb)))
(define m_custom (new menu% (label "Rocket") 
                            (parent mb)
                            (help-string "This is a menu I made")))
(define m_test0 (new menu-item% 
                     (parent m_custom)
                     (label "Say Hi")
                     (callback (lambda (b e) 
                                 (message-box "Hi" 
                                              "Hi! You clicked a menu item" 
                                              main-window)))))
(append-editor-operation-menu-items m-edit #f)
(append-editor-font-menu-items m-font)



(send main-window show #t)

(send t insert "Hi\n")
(send t insert "Hey~~\n")
(send t insert "How are you?\n")
(send t insert "I'm fine, thanks.\n")