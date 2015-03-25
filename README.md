#### My Library: XML Parsing and Writing

The first library that I decided to explore is XML:Parsing and Writing. It's the one I'm most familiar with since I took a class with Professor Heines who taught me the basics of the xml format. 

My first code written for this library is a simple parsing procedure that reads my xml file called "Test.xml".  
The contents of the xml file is as following:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Camelot><King_Arthur><person gender="Male"/><duty Occupation="King Of Camelot"/></King_Arthur</Camelot>
```

and the code I wrote was:
```scheme
(define (test) (open-input-file "Test.xml") )

(define (read t)(xml->xexpr (document-element
               (read-xml (t)))))

 (read test)                           
'(Camelot () (King_Arthur () (person ((gender "Male"))) (duty ((Occupation "King Of Camelot")))))                        
```                            
It produced a list with a similar structure to the one in my xml file. Which is convenient because I can use tree operations to manipulate it.

Eventually I formatted my xml file to look presentable by putting the elements in their own line. The reason for this was because I wanted to see the overall structure more clearly.
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Camelot>
<King_Arthur>
<person gender="Male"/>
<duty Occupation="King Of Camelot"/>
</King_Arthur>
</Camelot>
```

However my first code produced a interesting output which reflected the change I did earlier.

```scheme
 '(Camelot
  ()
  "\r\n"
  (King_Arthur
   ()
  "\r\n"
  (person ((gender "Male")))
   \r\n"
   (duty ((Occupation "King Of Camelot")))
   "\r\n")
   "\r\n")
  ```
Every element is accompanied by "\r\n" which is the window's equivalent of newline. Of course this gets annoying as you need to account for this in each newline you make. Fortunately there are many ways to deal with this problem. 

For example, I quickly made a flatten procedure to turn my tree into a simple list. From there I used the Remove* procedure to take the newline characters out which leaves me with a nice and clean list.

```scheme
(define (flatten x)
    (cond ((null? x) '())
          ((not (pair? x)) (list x))
          (else (append (flatten (car x))
                        (flatten (cdr x))))))
 ```                       

