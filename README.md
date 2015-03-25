# Final Project Assignment 1: Exploration (FP1) 
DUE March/25/2005

### My Libraries: racket/gui, rsound, portaudio and ffi/vector

I like music, sound and I play guitar as a hobby, poorly. I would like my final project to involve the manipulation of sound. The portaudio library provides data types and procedures for the generation of sound. I used this library along with the rsound library, which provides useful bindings for the portaudio package, to generate a single tone. I am not very well versed in how sound is represented digitally, so I just copied the racket documentation for generating a sine wave. I made some modifications to allow manipulation of the wave by the user by using the racket/gui library. I created a window that allows the user to press a button to generate a single tone. I also added a volume slider to to the window so the user can adjust the volume of the tone generated. As the user adjusts the volume slider the the amplitude of the sine wave is either reduced or increase thereby lowering or increasing the volume of the tone played.


##Code

#lang racket

'''
;; require libraries
(require racket/gui
         rsound
         ffi/vector)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;SOUND CODE;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define pitch  523.253) ;; C5
(define sample-rate 44100.0) ;; how many times we sample a sound. the higher the more realistic.
(define tpisr (* 2 pi (/ 1.0 sample-rate))) ;; 2pi * 44100.0, i took this from the racket documents.
;;(define volume .05) ;; affects amplitude of sin wave affecting it's loudness.

(define vec (make-s16vector (* 88200 2))) ;; creates an array of 16 bit ints of len 88200 * 2

(define (set-sample index volume)
  ;; code copied from documentation that was originally within a C style for loop.
  (define sample (real->s16 (* volume (sin (* tpisr index pitch)))))
  (s16vector-set! vec (* 2 index) sample)
  (s16vector-set! vec (add1 (* 2 index)) sample))

;; fills the array with sine wave samples.
(define (fill-vec vol)
  (define (helper curr-ind len ret-val)
    (if (> curr-ind len)
        (void) ;; return nothing.
        (helper (+ curr-ind 1) len (set-sample curr-ind vol))))
  (helper 0 (- (/ (s16vector-length vec) 2) 1) null))

(define (create-tone vol)
  (fill-vec vol) ;; create vec with specific volume setting
  (rsound vec
          0
          88200
          sample-rate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;GUI CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; instantiating a frame class instance.
(define frame (new frame% [label ""]
                   [min-width 300]
                   [min-height 150]))

(define (display-frame frame)
   (send frame show #t))

;; volume slider!
(define slider (new slider%
                    [label "volume"]
                    [parent frame]
                    [min-value 0]
                    [max-value 10]
                    [init-value 5]
                    [callback (lambda (control event)
                                (stop)
                                (play (create-tone (/ (send slider get-value) 80))))]))

; Make a button in the frame
(new button% [parent frame]
             [label "click to play sound."]
             ; Callback procedure for a button click:
             [callback (lambda (button event) ;; executed when a botton is clicked!
                         (stop) ;; prevent multiple presses from overlapping the tones playing.
                         (play (create-tone  (/ (send slider get-value) 80))))])

; Show the frame by calling its show method
;;(send frame show #f)
(display-frame frame)
'''

Write what you did!
Remember that this report must include:
 
* a narrative of what you did
* the code that you wrote
* output from your code demonstrating what it produced
* any diagrams or figures explaining your work 
 
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.

### How to Do and Submit this assignment

1. To start, [**fork** this repository][forking].
1. You might want to [**Clone**][ref-clone] this repository to your computer
  2. (This assignment is just one README.md file, so you can edit it right in github without cloning if you like)
1. Modify the README.md file and [**commit**][ref-commit] changes to complete your solution.
1. [**Push**][ref-push]/sync the changes up to your GitHub (skip this if you didn't clone)
1. [Create a **pull request**][pull-request] on the original repository to turn in the assignment.

<!-- Links -->
[piazza]: https://piazza.com/class/i55is8xqqwhmr?cid=411
[markdown]: https://help.github.com/articles/markdown-basics/
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
