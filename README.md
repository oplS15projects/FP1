# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)


### My Library: racket/gui/base

Name: Yong Cho


##### Racket's GUI Library

I have chosen to explore the Racket's built-in GUI library.
I read through [**Racket GUI Toolkit webpage**][racket-gui-toolkit] which contains most information needed to create a basic GUI interface that works with the major desktop operating systems. I chose this library because I thought that being able to use the graphical interface would be a basis for creating any application that interacts with users.

From reading through the above documentation, I learned how to:
* create a window
* place controls in the window
* configure properties of a GUI object
* link keyboard and mouse event to procedures



##### Walkthrough of what I did

Creating a window in Racket is accomplished by instantiating the frame% class. Here is an example.

```
#lang racket
(require racket/gui/base)
(define main-window (new frame% (label "1.1 Creating Windows") (width 300) (height 300)))
(send main-window show #t)
```

![empty_window.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/empty_window.PNG)

The frame class represents a top level window which has a title, minimize, maximize, and close buttons, scrollbars and so on. You can define certain attributes of the window when instantiating the frame class such as its title, position on the screen, horizontal and vertical size, and so on.

Once I had the window running, I moved on to adding controls in it. [**Racket Widget Gallery page**][widget-gallery] lists all the control widgets available and how to use them in a very reader friendly format.

Each Racket GUI element is within a hierarchy of elements where every element has a parent element, maybe except for the root window. I believe this is how the interpreter knows which element belongs to which window. When you want to place a GUI element, you need to define its parent. For example, when I write:

```
(define msg-greeting (new message% (parent main-window)
                                   (label "Hello, Yong")))
```

Racket knows the message object needs to be placed into the object 'main-window'. Message object is literally a simple text message displayed in a window. 

![message.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/message.PNG)

You can make the text change at runtime by calling `set-label` which is a member procedure of the message class.

```
(send msg-greeting set-label "This is a message object.")
```

![message-set-label.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/message-set-label.PNG)

Using send procedure is pretty much how all the member procedure is called, at least from what I have seen. Notice some portion of the message text is cut off because the text is too long to fit in the original size of the message object. You can fix this by calling `(send msg-greeting auto-resize #t)`. Auto-resize is another member procedure of the message class which adjusts the container size based on its text content. Here is the fixed output.

![message-set-label-auto-resize.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/message-set-label-auto-resize.PNG)



You can use any GUI object listed in the [**Racket Widget Gallery**][widget-gallery] in the similar way. You instantiate an object using `(new <class-name%> ...` and specify its parent window. Here is another example with a button object.

```
(new button%
     (parent main-window)
     (label "Browse..."))
```

![message-and-button.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/message-and-button.PNG)

You can click the button all you want, but nothing happens at this point. In order to make the button do something, you need to supply a procedure. Here is an example.

```
(new button%
     (parent main-window)
     (label "Browse...")
     (callback (lambda (b e)
                 (get-file))))
```

This will invoke a file-open dialog.

![button-file-open.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/button-file-open.png)

As you may have noticed, the lambda procedure that follows the callback specifies what you want happen when the click event happens. `(get-file)` is a built-in procedure which calls the OS's file-open dialog. A callback procedure seems to be the way to handle events in many Racket examples I have seen. I have yet to figure out completely what its two arguments `(b e)` are for. You can name the arguments whatever you want, but a callback procedure must have two arguments even if you don't use them, otherwise you get an error.

Here is the entire source code so far. You can copy it to the Dr.Racket and see it running.

```
#lang racket

;http://docs.racket-lang.org/gui/index.html

(require racket/gui/base)

(define main-window (new frame% (label "1.1 Creating Windows") (width 300) (height 300)))
(define msg-greeting (new message% (parent main-window)
                                   (label "Hello, Yong")))
(new button%
     (parent main-window)
     (label "Browse...")
     (callback (lambda (button event)
                 (get-file))))

(send main-window show #t)

```




Below is another code piece I wrote. This time, I am using the horizontal-panel% class which organizes the controls horizontally instead of the default top-down manner. I am also actually catching the output from the file-open dialog and displaying the selected file's path in a text-field. Feel free to modify and use them for yourself.

![file-open.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/file-open.PNG)


```
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

```




Finally, here is a simple text editor application I wrote which incorporates different GUI elements.

![text-editor-v0_1.png](https://raw.githubusercontent.com/YongCho/FP1/master/image/text-editor-v0_1.png)

```
;Simple Text Editor (Exploring Racket GUI Library) 
;Created on 3/20/2015
;Author: Yong Cho

;References:
;http://docs.racket-lang.org/gui/windowing-overview.html#%28part._.Creating_.Windows%29
;http://docs.racket-lang.org/gui/editor-overview.html
;http://docs.racket-lang.org/gui/text_.html
;http://docs.racket-lang.org/gui/Widget_Gallery.html
;http://docs.racket-lang.org/gui/tab-panel_.html
;http://docs.racket-lang.org/gui/area-container___.html
;http://docs.racket-lang.org/reference/Manipulating_Paths.html
;http://docs.racket-lang.org/guide/ports.html
;http://docs.racket-lang.org/gui/editor-stream-out_.html

;Questions:
;How to detect content change in the text editor?


#lang racket
(require racket/gui/base)

; root window
(define main-window (new frame%
                         (label "Simple Text Editor v0.1")
                         (width 600)
                         (height 600)))

; menu area
(define mbar (new menu-bar% (parent main-window)))
(define m-file (new menu% (label "File") (parent mbar)))
(define m-edit (new menu% (label "Edit") (parent mbar)))
(define m-font (new menu% (label "Font") (parent mbar)))
(define m-custom (new menu% (label "Rackit") 
                            (parent mbar)
                            (help-string "This is a menu I made")))

; A test menu item - "SayHi"
; Opens a message box when clicked
(define mi-sayhi (new menu-item% 
                      (parent m-custom)
                      (label "Say Hi")
                      (callback (lambda (b e) 
                                  (message-box "Hi" 
                                               "Hi! You clicked a menu item" 
                                               main-window)))))

; "Open..." File menu item
(define mi-fileopen (new menu-item%
                         (parent m-file)
                         (label "Open...")
                         (callback (lambda (b e)
                                     (let ((filepath (get-file)))
                                       (if (not (equal? filepath #f))
                                           (loadtext filepath)
                                           0))))))

; "Save As..." File menu item
(define mi-saveas (new menu-item%
                       (parent m-file)
                       (label "Save As...")
                       (callback (lambda (b e)
                                   (let ((filepath (put-file)))
                                     (if (not (equal? filepath #f))
                                         (savetext filepath)
                                         0))))))

; Loads the contents of a text file into the editor
(define (loadtext filepath)
  (define in (open-input-file filepath))
  (send text-area insert (port->string in))
  (close-input-port in))

; Saves the contents of the editor into a file
; TODO: Remember the currently opened file and save to that
; file.
(define (savetext filepath)
  (define out (open-output-file filepath #:mode 'text #:exists 'truncate))
  (define contents (send text-area get-text))
  (display contents out)
  ;(send text-area write-to-file out)
  (close-output-port out))

; "Edit" menu contains a set of useful editor features such as cut, copy, paste, and so on.
; It is provided in the library.
(append-editor-operation-menu-items m-edit #f)
; "Font" menu contains a set of options to customize fonts. Also implemented in the library.
(append-editor-font-menu-items m-font)

; tab area
(define tab-panel (new tab-panel%
                       (parent main-window)
                       (choices (list "Untitled 1" "Untitled 2"))
                       (callback (lambda (tp e)
                                   (case (send tp get-selection)
                                     ((0) (send tp change-children 
                                                (lambda (children) (list a-panel))))
                                     ((1) (send tp change-children 
                                                (lambda (children) (list b-panel)))))))))

; contents area (where the editor goes)
(define a-panel (new panel% (parent tab-panel)))
(define a-text (new message% (parent a-panel) (label "A-panel")))
(define b-panel (new panel% (parent tab-panel)))
(define b-text (new message% (parent b-panel) (label "B-panel")))
(send tab-panel delete-child b-panel)
 
; editor
(define ec (new editor-canvas% (parent a-panel)))
(define text-area (new text%))
(send ec set-editor text-area)


(send main-window show #t)

```

This text editor has minimal features such as opening a text file, editing its contents, and saving it to a file. It also has basic editing features such as copy, cut, and paste which are provided by a built-in library procedure. I started impementing tabs to make it work with multiple documents at the same time, but did not finish it because I thought that would be too much for the purpose of exploring the library. 


##### Conclusion

Racket provides a quick and easy way to create a GUI interface. All the GUI controls exist as a high-level object which a programmer can use by instantiating them with a single-line code. 





<!-- Links -->
[racket-gui-toolkit]: http://docs.racket-lang.org/gui/
[widget-gallery]: http://docs.racket-lang.org/gui/Widget_Gallery.html
