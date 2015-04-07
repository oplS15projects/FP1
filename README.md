


I investigated one of rackets Libraries for plotting graphs, this librayr can plot 2d and 3d graphs. It seems straight forward enough the plot3d function takes a procedure called surface3d wich takes an equation as a lmbda. So it seems surface 3d takes a lambda representing one or more mathmeatical functions with only variables x and y.I treid using plot-frame procedure and I ended up getting into contracts.


(define (action x y )
 
   (plot3d-frame (
                  
          surface3d (λ (x y ) ( * (sin x) (cos x) (sin y)))
                     (- pi) pi (- pi) pi)
          #:title "An R × R → R function"
          #:x-label "x" #:y-label "y" #:z-label "cos(x) sin(y)"))
