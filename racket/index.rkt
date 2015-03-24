#lang racket
(require web-server/servlet
         web-server/servlet-env
         web-server/http
         web-server/dispatchers/dispatch)

(define (my-app req)
  (response/xexpr
   '(html

     (head (meta ((charset "utf-8")))
           (title "OPL Exploration 1")
           (link ( [rel "stylesheet"]
                   [type "text/css"]
                   [href "css/main.css"])))

     (body (div ((class "header"))
                (div ((class "title"))
                     (img ([class "logo"]
                           [src "http://www.eecs.northwestern.edu/~robby/logos/plt-logo-red-diffuse.png"]))
                     "OPL Spring 2015")

                (div ((class "menu"))
                     (ul (li (a ((href "/")) "home"))
                         (li (a ((href "https://github.com/josefflores/FP1")) "github"))
                         (li (a ((href "index.rkt")) "source"))
                         (li (a ((href "output.html")) "output")))))

           (div ((class "content"))
                (h2 "Assignment")
                (h3 "Narrative")
                (p "As instructed I went on the racket website and looked at the libraries that were available. After examination and taking my professional interests into account, graphics and web developement, I decided to work with the web-server library. I thought that it would be interesting to learn how to build a web page with Racket.")

                (p "I started by reading the documentation to become familiar with how the library worked. I investigated how an html page was created, how attributes were added to elements.")

                (p "Once I knew how to modify the elements I then gave myself the task of creating a header bar with a menu system. The menu would have links to both the current page and an external source; I used the Github project fork page as an external link.")

                (p "Once I had the structural elements working, I then decided to modify the styling of the page. I completed the header using the racket logo from an external resource and titled the page.")

                (p "Since I am investigating how to make webpages with Racket I decided to continue writing the report with Racket. I figured it would be a good way of discovering how making a webpage was like and seeing the differences from other server languages I have used in the past." )

                (p "I found that the documentation and resoources for constructing webpages is lacking for racket since there are other more popular server options out there, but they exist. I had a lot of trouble following how to include external static files using what was in the documentation as the example was incomplete. Following the example given in the article found at " (a ((href "http://www.greghendershott.com/2013/03/serve-static-files.html")) "www.greghendershott.com") ", I was able to figure it out."))))))

(serve/servlet my-app
                #:servlet-path "/"
                #:extra-files-paths (list "./htdocs")
                #:port 8080
                #:launch-browser? #t)
