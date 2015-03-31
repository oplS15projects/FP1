# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: rsound, racket/gui

I mostly played around with the rsound library, which is dedicated to reading, writing, and manipulating audio. 
I was able to record myself using my computer's built in mic, and write various generated audio files to disk. 
I did some reading and came accross rsound's "network" construct, which is composed of smaller nodes whose functionality contributes to generating or maipulating signals that are representative of audio data. Each network is inteded to perform
a specific task. For instance, one network may generate a sine wave while another may attenuate the value of some signal
that it's past. I decided to create a network that produced an amplitude-modulated signal by mulitplying a carrier wave
with a modulating wave to produce a tremolo effect. 
Another thing I did was generate three tones with a pinao's timbre (musical color) that when combined form an a-major chord.
I wrote the a-major chord and the amplitude-modulated audio signal to disk.

I intended to do some experimenting with racket's gui library, and eventually provide a graphical interface that would allow
users to adjust the frequency of the carrier wave and the modulator wave, but unfortunatley I didn't get too far. I kept getting this error message: "cannot instantiate `racket/gui/base' a second time in the same process". I tried searching
the web for solutions, but nothing did the trick. I think there may be a compatibility issue with my system's GUI 
back-ends and racket's GUI modules...
 
Here's my code:
```
lang racket
(require rsound
         rsound/piano-tones)

;Produces an Amplitude Modulated signal. Using the "network" construct
;found in the rsound library, I generate carrier frequency (100 Hz) and
;a modulator frequency (2 Hz). The two generated sine waves are multiplied 
;together thus producing a modulated signal.
(define AMSig
  (network ()
          [mod <= sine-wave 2]
          [sin <= sine-wave 100]
          [out = (* mod sin)]))

;This procedure converts the previously generated signal from type "signal" 
;to type "rsound" and creates a buffer of size (* 44100 4) to store the 
;resultant values. The default sample rate of the rsound library is 44100, 
;and the default bit-depth is 16. Upon playback of an audio file, this means 
;that 44100 samples (each of size 2 bytes) are read per second. So, a buffer
;of size (* 44100 4) will play audio for 4 seconds at a sample rate of 44100.
(define audioSample (signal->rsound (* 44100 4) AMSig))

;Defines path to write audio file to.
(define writeToPath1 "/somepath.../AMSig.wav")

;Writes audio file to path.
(rs-write audioSample writeToPath1)

;The piano-tone procedure accepts a midi-note value arugment and
;returns an 1 second audio sample of a piano being played at that
;note. Below I created created 3 different samples of specific notes
;that combine to form an a major triad.
(define a (piano-tone (pitch->midi-note-num 440)))
(define c# (piano-tone (pitch->midi-note-num 554)))
(define e (piano-tone (pitch->midi-note-num 659)))

;rs-overlay combines both sounds its provided and to form a single new sound.
(define majorThird (rs-overlay a c#))
(define majorTriad (rs-overlay majorThird e))

;Defines path to write audio file to.
(define writeToPath2 "/somepath.../Triad.wav")

;Writes audio file to path.
(rs-write majorTriad writeToPath2)


#|

Code dependent on racket's gui library. The library didn't work properly on
my computer.

(define frame (new frame%
                   [label "Amplitude Modulator"]
                   [width 300]
                   [height 300]))


(define slider_carrierFreq (new slider%
                               (label "Carrier Frequency")
                               (parent frame)
                               (min-value 20)
                               (mav-value 880)
                               (init-value 80)))

(define slider_modulatorFreq (new slider%
                                  (label "Modulator Frequency")
                                  (parent frame)
                                  (min-value 0)
                                  (max-value 15)
                                  (init-value 1)))

(send frame show #t)
|#
                               
```
[Click here for my generated audio files on SoundCloud](https://soundcloud.com/you/tracks)
