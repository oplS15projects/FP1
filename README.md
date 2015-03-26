# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Library: (Web Server / Templates)
For my library I chose to use the Web Server library as I plan on making a web application as the final project. I needed to understand how to create a structured HTML file in scheme first so I went with the library that Mark linked me to. To avoid repition and to abstact out a portion of the web page, I chose to implement the templates library for the web server to allow me to exclude the header and footer of the page.

```
(require 
     web-server/servlet
     web-server/servlet-env
     web-server/templates
)


(define (start req)
     (response/xexpr
     '(html
          ,(let ([title "League of Stats"]) (include-template "views/header.html"))
          (div ((class "row") (id "landing"))
               (div ((class "col-md-4 col-md-offset-4 platform") (style "padding-top: 100px"))
                    (h1 "Summoner Lookup")
                    (p "Welcome to will they feed, the site that crunches the numbers 
                             for you, and tells you the likelyhood that your teammate will 
                              feed! Simply enter their Summoner name below, and be amazed!"
                       )
                    (form
                          "Enter a Summoner Name: "
                          (input ([name "name"]))
                          (input ([type "submit"]))
                    )
                    )
          )
          ,(let ([brand "Noxus"]) (include-template "views/footer.html"))
     )
     )
)

(serve/servlet start)
```

I also passed variables to the views as that is something that we will need to do when we develop our statistics app. The output of the program can be viewed in output.html, it's too large to include here. All CSS is included, but I left out the Javascript and didn't use page animation, that'll be implemented later.
