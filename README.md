# Final Project Assignment 1: Exploration (FP1) 

By Tyler Alterio

DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: racket/gui

So when the project was announced I had no idea what to write. I figured the project would have a little more structure. Instead it's literally just "You have to write some application." So I figured I'd pick a very generic library. Some library that could be applied to any application. I figured every program needs a front-end, therefore I decided to take a look at what GUI forms Racket had to offer.

Rather simply, I googled "racket gui" and was brought to [this webpage][racket-gui]. After reading on, I saw the GUI toolbox is seperated into two catagories:

* Windowing - For implementing windows, buttons, menus, text fields, and more.
* Editors - For developing text editors and free-form layout editors.

The second part sounds interesting, however I doubt I'd need such a complicated system. I want to see how far I can get with the simple windowing kit. Also it seems as though the first catagory is more like GUI libraries that I've used. So for the most part I'll stick to windowing.

I learned that Racket is object oriented. Now I'm not against object-oriented code in a LISP, I write Clojure for god's sake, but the way Racket handles objets seems weird. It seems like some sort of prototyping model. You use the `new` function to clone an initial object (which by naming convention ends with a %) and override it's fields. So...

```(define frame (new frame% [label "Example"]))```

This code defines frame as a new object of `frame%`, overiding the label field to be the string "Example". I guess all the other fields stay as their own default value. Some fields are required, but the majority of them are optional. This at least makes sense for GUI objects because they are mostly static. It also seems there is a `send` function that runs the method of an object that can change the state of some fields. So this just boiled down to making objects and seeing how there worked with each other.

So I ended up making 4 objects. A frame, which is just the window that holds everything. The other 3 objects list the frame as it's parent. The parent contains it's children, and destructs them when it is destructed. I made a text box for user input. I also made a text message for ouput. And then a button to run the code. For proof of concept I created a program makes a window that converts celsius to fahrenheit, because who uses the metric system? I am including the code in the pull request along side this README.md.


<!-- Links -->
[racket-gui]: http://docs.racket-lang.org/gui/