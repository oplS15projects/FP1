# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### Experimenting with the RSound/piano-tones library. 

<h3>Introduction</h3>

For the first part our final project I decided to play around with the ‘RSound’ library.  From the description on the library’s site: “This collection provides a means to represent, read, write, play and manipulate sounds.”

The full description can be found here: http://pkg-build.racket-lang.org/doc/rsound/index.html

I decided to experiment with the library’s piano tones.  I did this because it seemed like an easy place to start, as the procedure for creating a sound at a specific pitch is very simple. Calling the ‘piano-tone’ procedure creates note objects, referred to as ‘rsounds’. The piano-tone procedure takes an integer from 0 to 127 to be used as a midi-note number (pitch in this instance).  The rsound objects are then played using the ‘play’ procedure. 

The current strategy for controlling the rhythm of notes being played is to call a sleep procedure to halt the system for a given amount of time, allowing the note to sustain.

For example:
```
(play (piano-tone 48))
(sleep 1)
(play (piano-tone 54))
(sleep 2)
```

The code above plays a piano tone with midi number 48 (C4 on a piano), then pauses for one second while the note sustains. The program then plays midi-note 54 (G4 on a piano) and pauses for two seconds while the note sustains. This pattern can be repeated to play a particular melody of pitches with durations. I have abstracted this pattern away into a few procedures and definitions that are much easier to use. This is described in the following section. I’d also like to mention that from what I understand, the rsound library has a much more sophisticated way to control a sequence of notes rather than calling sleep to control their durations. This is something I intend to spend some time learning and experimenting with, but have not yet done so at this time. 

<h3>Program Description</h3>

I began by first defining a series of rsound objects using the piano-tone procedure, giving them their formal musical names. 

Ex:
```
(define e3 (piano-tone 40))
(define f3 (piano-tone 41))
(define f#3 (piano-tone 42))
```

I then created tempo and note-duration definitions. By default, a quarter note (one beat in 4/4 time) is one second (60 bpm). All other note durations are defined similarly. 

Ex:
```
(define tempo 1)

(define trip (/ .333 tempo))
(define eight (/ .5 tempo))
(define quarter (/ 1 tempo))
(define half (/ 2 tempo))
(define whole (/ 4 tempo))
```

The tempo variable allows for the length of time for each note duration to be reduced, making the melody faster as the tempo is increased. 

The playNote procedure then takes note and duration (integer) arguments and plays the given note for the appropriate amount of time. 

Ex:
```
  (define (playNote note length)
  (play note)
  (sleep length))
```

This allows somewhat complex melodies to be generated simply by providing the formal note name and the note duration.

Ex:
```
(playNote d4 trip)
(playNote c5 half)
(playNote g4 quarter)
(playNote f4 trip)
```

My next plan for the project is to store these sequences of notes and durations in lists so that entire melodies can be called by name, rather than built manually note by note. 

<h3>Program Code</h3>

```
#lang racket
(require rsound)
(require rsound/piano-tones)

;Note defintions. This takes a little while to build.

(define e3 (piano-tone 40))
(define f3 (piano-tone 41))
(define f#3 (piano-tone 42))
(define g3 (piano-tone 43))
(define ab3 (piano-tone 44))
(define a3 (piano-tone 45))
(define bb3 (piano-tone 46))
(define b3 (piano-tone 47))
(define c4 (piano-tone 48))
(define c#4 (piano-tone 49))
(define d4 (piano-tone 50))
(define d#4 (piano-tone 51))
(define e4 (piano-tone 52))
(define f4 (piano-tone 53))
(define f#4 (piano-tone 54))
(define g4 (piano-tone 55))
(define ab4 (piano-tone 56))
(define a4 (piano-tone 57))
(define bb4 (piano-tone 58))
(define b4 (piano-tone 59))
(define c5 (piano-tone 60))

;Tempo and note duration defintions. 

(define tempo 1.5)
(define trip (/ .333 tempo))
(define eight (/ .5 tempo))
(define quarter (/ 1 tempo))
(define half (/ 2 tempo))
(define whole (/ 4 tempo))

(define (playNote note length)
  (play note)
  (sleep length))

;;The star wars melody!

(playNote g3 trip)
(playNote g3 trip)
(playNote g3 trip)
(playNote c4 half)
(playNote g4 half)
(playNote f4 trip)
(playNote e4 trip)
(playNote d4 trip)
(playNote c5 half)
(playNote g4 quarter)
(playNote f4 trip)
(playNote e4 trip)
(playNote d4 trip)
(playNote c5 half)
(playNote g4 quarter)
(playNote f4 trip)
(playNote e4 trip)
(playNote f4 trip)
(playNote d4 half)

```


