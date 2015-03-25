# Final Project Assignment 1: Exploration (FP1)
DUE March/25/2005

### My Libraries: racket/gui, rsound, portaudio and ffi/vector

I like music and I play guitar, poorly, as a hobby. I would like my final project to involve the manipulation of sound. The ffi/vector, rsound and portaudio racket libraries contain the necessary procedures and data types to generate sound. I am not very well versed in how sound is represented digitally. I just copied the racket documentation for generating a basic sine wave and extended the code. I intend to research this later so I have a better understanding of the inner workings.

I made some of my own modifications to the documentation code to allow for a user to manipulate the sine wave generated by using the racket/gui library. Delving into the gui library would be beneficial to any project regardless of the topic. I created a window that allows the user to press a button to generate a single tone. I also added a volume slider to the window so the user can adjust the volume of the tone generated. As the user adjusts the volume slider the the amplitude of the sine wave is either reduced or increased thereby lowering or increasing the volume of the tone played. It is very primitive and is not an ideal way to lower the volume of the tone.

I also added another function to my primitive gui app. I added a save feature. The user specificies a file path and the tone with its selected slider volume will be saved to a file! I am not sure what the format of the audio file is.


##Code

```
#lang racket

;; libraries used
(require racket/gui
         rsound
         ffi/vector)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;SOUND CODE;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define pitch  523.253) ;; will play a C5 pitched note

(define sample-rate 44100.0) ;; how many times we sample a sound. the higher the more realistic.
(define tpisr (* 2 pi (/ 1.0 sample-rate))) ;; i took this from the documentation for portaudio.

(define vec (make-s16vector (* 88200 2))) ;; creates an array of 16 bit ints of length 88200 * 2

(define (set-sample index volume)
  ;; copied code from documentation that was originally within a C style for loop.
  ;; added a volume parameter for adjusting the amplittude of the sine wave for changing the loudness of the tone to be played.
  (define sample (real->s16 (* volume (sin (* tpisr index pitch)))))
  (s16vector-set! vec (* 2 index) sample)
  (s16vector-set! vec (add1 (* 2 index)) sample))

;; fills the array with sine wave samples.
(define (fill-vec vol)
  ;; modified documentation code that does the same thing as this procedure, but was in the C style.
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
                    ;; as the slider is moved by the user the callback procedure is executed.
                    [callback (lambda (control event)
                                ;; stop current tone
                                (stop)
                                ;; play tone with adjusted volume
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
```
