#lang racket

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