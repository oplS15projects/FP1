The first library I decided to explore is XML:Parsing and Writing. It's the one I'm most familiar with since I took a class with Professor Heines who drilled the basics of XML operations and format into my head.

My first code written for this library is a simple parsing procedure that reads my xml file called "Test.xml".  
The contents of the xml is as following:
```
<?xml version="1.0" encoding="UTF-8"?>
<Kamelot><King>Arthur</King></Kamelot>
```

and the code I wrote was:
```
(xml->xexpr (document-element
                            (read-xml(open-input-file "Test.xml"))))
                            
'(Kamelot () (King () "Arthur"))                          
```                            
