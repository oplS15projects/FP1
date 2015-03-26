#lang racket/gui
(require sgl
         sgl/gl
         sgl/gl-vectors)

(define deg2rad (/ pi 180.0))

(define rot 0.0)

(define (resize w h)
  (glViewport 0 0 w h))

(define (draw-opengl)
  ; Clear the canvas by drawing over everything with black.
  (glClearColor 0.0 0.0 0.0 0.0)
  (glClear GL_COLOR_BUFFER_BIT)
 
  (glShadeModel GL_SMOOTH)
 
  ; Reset the camera to an orthographic projection identity. 
  ; (Drawing starts at the bottom left.)
  (glMatrixMode GL_PROJECTION)
  (glLoadIdentity)
  (glOrtho 0.0 1.0 0.0 1.0 -1.0 1.0)
  (glMatrixMode GL_MODELVIEW)
  (glLoadIdentity)
  
  ; Rotate the drawing.
  (gl-translate 0.5 0.5 0.0)
  (gl-push-matrix)
  (gl-rotate rot 0.0 0.0 1.0)
 
  ; Set to triangle drawing mode.
  (glBegin GL_TRIANGLES)
  
  ; Sets the color and three vertices that define a triangle.
  ; If a different color is used for each vertex, it will create a blend 
  ; of colors starting from the vertex and going towards the center of the triangle.
  (glColor3f 1 0 0)
  (glVertex3d -0.25 0.25 0.0)
  (glColor3f 0 1 0)
  (glVertex3d 0.25 0.25 0.0)
  (glColor3f 0 0 1)
  (glVertex3d 0.25 -0.25 0.0)
  
  ; End triangle drawing.
  (glEnd)
  
  ; Set to line drawing mode.
  (glBegin GL_LINE_STRIP)
  
  ; Draw some lines.
  (glVertex3d -0.25 0.25 0.0)
  (glVertex3d -0.25 -0.25 0.0)
  (glVertex3d 0.25 -0.25 0.0)
  
  ; End line drawing.
  (glEnd)
  
  ; Used for drawing a circle.
  (glBegin GL_TRIANGLE_FAN)
  
  ; Draw a circle by putting a vertex at a certain distance (the radius) away from the center at 360 different angles.
  (define radius 0.125)
  (glColor3f 0 0 0)
  (glVertex3f 0.0 0.0 0.0)
  (for ([i 361])
    (define rad (* i deg2rad))
    (glVertex3f (* (cos rad) radius) (* (sin rad) radius) 0.0))
  
  ; End triangle fan drawing.
  (glEnd)
  
  ; Undo the rotation matrix so everything after is drawn normally.
  (gl-pop-matrix))
 
 
; No idea how any of this works. Probably magic.
(define my-canvas%
  (class* canvas% ()
    (inherit refresh with-gl-context swap-gl-buffers)
    
    (define/public (STEP)
      (set! rot (+ rot 2.0))
      (refresh)
      (sleep/yield 1/60)
      (queue-callback (lambda _ (send this STEP)) #f))
    
    (define/override (on-paint)
      (with-gl-context (λ() (draw-opengl) (swap-gl-buffers))))
    
    (define/override (on-size width height)
      (with-gl-context (λ() (resize width height))))
    
    (super-instantiate () (style '(gl)))))
 
(define win (new frame% [label "OPL FP1"]
                        [min-width 600] [min-height 600]))
(define gl  (new my-canvas% [parent win]))
 
(send win show #t)
(send gl STEP)