#lang racket
(require 
     web-server/servlet
     web-server/servlet-env
     web-server/http
     web-server/dispatchers/dispatch
)

(define (my-app req)
     (response/xexpr
     '(html

          (head (meta ((charset "utf-8")))
               (title "LoL Stats")
               (link ([rel "stylesheet"]
                      [type "text/css"]
                      [href "css/main.css"])
               )
          )

          (body 
               (div ((class "container"))
                    (h1 "Summoner Lookup")
                    (form ([action ,k-url])
                          "Enter a Summoner Name: "
                          (input ([name "name"]))
                          (input ([type "submit"])))
               )

               (div ((class "content"))
               )
          )
     )
     )
)

(serve/servlet my-app
     #:servlet-path "/"
     #:extra-files-paths (list "./htdocs")
     #:port 8080
     #:launch-browser? #t
)