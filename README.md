# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

# OPL-Project
## Exploration of the Icon Library
######by Alex Nevers

 For the beginning of the final project I began by exploring the icon section of the picture library, as I was interested in how racket handled generated images.  The icon library is well populated, and it turns out many icons in racket are made of several smaller overlapping icons. One example as I reproduced was the first output of my tests, overlapping the step icon with the record icon. The record icon was changed from red to green using the #:color tag, as well downsizing the icon. The step icon was then super imposed over the record icon to result in the first icon on the output.

 The next output is a list of varying bomb icons. The height for the bombs was increased by using a list of height values plugged into the for/list procedure, as well as having the icon material value changed by a material list. The for/list procedure was also used to print the individual frames from the running man animation used when compiling code in racket, as shown in the final output.

 Similarly, for the polygon list, a polygon was generated for all sides in range from 1 to 9, with the icon material and color cycled through from two lists of material types and color values, respectively.

 Checking out the icon library is interesting, and being able to create new icons from super imposing pre existing ones, along with changing height, color, and material values, seems to lead to a lot of possible combinations. I feel a bit out of my depth when it comes to the new procedures used to mess with these images and icons, but it is interesting.


####Output

Capture of output from the below program [here.](http://imgur.com/loVFnSB)


####Test Code
    #lang racket
     (require pict images/icons/control images/icons/style)
     (require images/icons/misc)
     (require images/logos)
     (require images/icons/stickman)
     
     ;;Step Icon superimposed on Record Icon;;
     
    (pict->bitmap
      (cc-superimpose
       (bitmap (record-icon #:color "forestgreen" #:height 32
                            #:material plastic-icon-material))
       (bitmap (step-icon #:color light-metal-icon-color #:height 15
                          #:material rubber-icon-material))))
      
      ;;Bomb Icon list with changed icon material and varying sizes;;
      
    (for/list ([material  (list plastic-icon-material
                              rubber-icon-material
                              glass-icon-material
                              metal-icon-material)]
            [height (list 30 35 40 45)])
    (bomb-icon #:height height #:material material))
      
      ;;Polygon List with cyclical color and icon material changes;;
     
       (for/list ([sides  (in-range 1 9)]
             [material  (in-cycle (list plastic-icon-material
                                        glass-icon-material
                                        metal-icon-material
                                        rubber-icon-material))]
             [color     (in-cycle (list "cornflowerblue" 
                                        "forestgreen" 
                                        "tomato"))])
  
    (regular-polygon-icon sides #:color color #:height 32
                          #:material material))
      
      ;;Stickman Running animation frames in list;;
      
      (for/list ([t  (in-range 0 1 1/12)])
    (running-stickman-icon t #:height 32))
    
    
