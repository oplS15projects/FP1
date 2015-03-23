;; Simple Text Editor (Exploring Racket GUI Library) 
;; Created on 3/20/2015
;; Author: Yong Cho

;; References:
;; http://docs.racket-lang.org/gui/windowing-overview.html#%28part._.Creating_.Windows%29
;; http://docs.racket-lang.org/gui/editor-overview.html
;; http://docs.racket-lang.org/gui/text_.html
;; http://docs.racket-lang.org/gui/Widget_Gallery.html
;; http://docs.racket-lang.org/gui/tab-panel_.html
;; http://docs.racket-lang.org/gui/area-container___.html
;; http://docs.racket-lang.org/reference/Manipulating_Paths.html
;; http://docs.racket-lang.org/guide/ports.html
;; http://docs.racket-lang.org/gui/editor-stream-out_.html

;; Questions:
;; How to detect content change in the text editor?


#lang racket
(require racket/gui/base)

;; root window
(define main-window (new frame%
                         (label "Simple Text Editor v0.1")
                         (width 600)
                         (height 600)))

;; menu area
(define mbar (new menu-bar% (parent main-window)))
(define m-file (new menu% (label "File") (parent mbar)))
(define m-edit (new menu% (label "Edit") (parent mbar)))
(define m-font (new menu% (label "Font") (parent mbar)))
(define m-custom (new menu% (label "Rackit") 
                            (parent mbar)
                            (help-string "This is a menu I made")))

;; A test menu item - "SayHi"
;; Opens a message box when clicked
(define mi-sayhi (new menu-item% 
                      (parent m-custom)
                      (label "Say Hi")
                      (callback (lambda (b e) 
                                  (message-box "Hi" 
                                               "Hi! You clicked a menu item" 
                                               main-window)))))

;; "Open..." File menu item
(define mi-fileopen (new menu-item%
                         (parent m-file)
                         (label "Open...")
                         (callback (lambda (b e)
                                     (let ((filepath (get-file)))
                                       (if (not (equal? filepath #f))
                                           (loadtext filepath)
                                           0))))))

;; "Save As..." File menu item
(define mi-saveas (new menu-item%
                       (parent m-file)
                       (label "Save As...")
                       (callback (lambda (b e)
                                   (let ((filepath (put-file)))
                                     (if (not (equal? filepath #f))
                                         (savetext filepath)
                                         0))))))

;; Loads the contents of a text file into the editor
(define (loadtext filepath)
  (define in (open-input-file filepath))
  (send text-area insert (port->string in))
  (close-input-port in))

;; Saves the contents of the editor into a file
;; TODO: Remember the currently opened file and save to that
;; file.
(define (savetext filepath)
  (define out (open-output-file filepath #:mode 'text #:exists 'truncate))
  (define contents (send text-area get-text))
  (display contents out)
  ;(send text-area write-to-file out)
  (close-output-port out))

;; "Edit" menu contains a set of useful editor features such as cut, copy, paste, and so on.
;; It is provided in the library.
(append-editor-operation-menu-items m-edit #f)
;; "Font" menu contains a set of options to customize fonts. Also implemented in the library.
(append-editor-font-menu-items m-font)

;; tab area
(define tab-panel (new tab-panel%
                       (parent main-window)
                       (choices (list "Untitled 1"))
                       (callback (lambda (tp e)
                                   (case (send tp get-selection)
                                     ((0) (send tp change-children 
                                                (lambda (children) (list a-panel))))
                                     ((1) (send tp change-children 
                                                (lambda (children) (list b-panel)))))))))

;; contents area (where the editor goes)
(define a-panel (new panel% (parent tab-panel)))
(define a-text (new message% (parent a-panel) (label "A-panel")))
(define b-panel (new panel% (parent tab-panel)))
(define b-text (new message% (parent b-panel) (label "B-panel")))
(send tab-panel delete-child b-panel)

;; adds a new tab
(define (create-new-tab)
  (define number-of-tabs (send tab-panel get-number))
  (send tab-panel append (- number-of-tabs 1)))
  

;; editor
(define ec (new editor-canvas% (parent a-panel)))
(define text-area (new text%))
(send ec set-editor text-area)


(send main-window show #t)
