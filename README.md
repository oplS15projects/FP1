


 I investigated one of rackets Libraries for plotting graphs, this librayr can plot 2d and 3d graphs. It seems straight forward enough the plot3d function takes a procedure called surface3d wich takes an equation as a lmbda. So it seems surface 3d takes a lambda representing one or more mathmeatical functions with only variables x and y. I just played around with different functions I could use with the procedure. Initialy I I copied the example with sin of x and sin of y and cos of x, the result was something that looked like a row of waves, in a seperate window the graph can be rotated and viewed from different angles.next I tried using tan along with some different values and got what looked like a tower between two walls. then I plotted a plane linear eqauation the reult was just a plane. I treid using plot-frame procedure and I ended up getting into contracts. I wraped the plot-3d procedure in another procedure called action that takes two values and passes then to the procedure. the library can also do 3d scatter plots. I tried implimenting in a recursive procedure but it seems that racket would recursively evaluate the procedure before ploting the the graph in a seperate window. hence I tried figuring out the plot3d-frame procedure. I figured I coud try and find a way  to plot the graph on a canvas to try and make it dynamic. As stated before this involved me reading into racket contracts which I dont quite understand as yet. It seems to be a more advanced part of the racket environment.


(define (action x y )
 
   (plot3d-frame (
                  
          surface3d (λ (x y ) ( * (sin x) (cos x) (sin y)))
                     (- pi) pi (- pi) pi)
          #:title "An R × R → R function"
          #:x-label "x" #:y-label "y" #:z-label "cos(x) sin(y)"))
