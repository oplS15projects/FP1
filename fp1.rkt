#lang racket

;Include racket/gui.
(require racket/gui/base)

;Create a top-level window and instantiate the frame% class.
(define n-frame (new frame% [label "Aperture Science"]
                     [width 650]
                     [height 335]))

;Create a static text message in the frame.
(define n-message 
  (new message% [parent n-frame]
                [label "Cake, and grief counseling, will be available at the conclusion of the test."]))

;Create a new canvas.
(new canvas% [parent n-frame]
     [paint-callback
      (lambda(canvas draw-context)
        ;Sets text scale, color, and string output.
        (send draw-context set-scale 2 2)
        (send draw-context set-text-foreground "black")
        (send draw-context draw-text "Aperture Science:" 90 10)
        ;Resets text scale, color, and string output.
        (send draw-context set-scale 1.5 1.5)
        (send draw-context set-text-foreground "blue")
        (send draw-context draw-text "We do what we must because we can." 70 35)
        (send draw-context draw-text "For the good of all of us," 115 50)
        (send draw-context draw-text "Except the ones who are dead." 90 65)
        (send draw-context draw-text "But there's no sense crying over every mistake." 25 80)
        (send draw-context draw-text "You just keep on trying 'til you run out of cake." 20 95)
        (send draw-context draw-text "And the science gets done," 115 110)
        (send draw-context draw-text "And you make a neat gun for the people who are..." 20 125)
        ;Resets text scale, color, and string output one more time.
        (send draw-context set-scale 3 3)
        (send draw-context set-text-foreground "black")
        (send draw-context draw-text "still alive!" 70 70))])

;Make a button in the frame.
(new button% [parent n-frame]
     [label "Click here for your cake!"]
     ;Create a callback procedure for a button click.
     [callback (lambda(button event)
                 (send n-message set-label "The cake is a lie. The cake is a lie. The cake is a lie."))])

;Displays the window.
(send n-frame show #t)

