The first library I decided to explore is XML:Parsing and Writing. It's the one I'm most familiar with since I took a class with Professor Heines who taught me the basics of XML format.

My first code written for this library is a simple parsing procedure that reads my xml file called "Test.xml".  
The contents of the xml file is as following:
```
<?xml version="1.0" encoding="UTF-8"?>
<Camelot><King_Arthur><person gender="Male"/><duty Occupation="King Of Camelot"/></King_Arthur</Camelot>
```

and the code I wrote was:
```
(xml->xexpr (document-element
                            (read-xml(open-input-file "Test.xml"))))
                            
'(Camelot () (King_Arthur () (person ((gender "Male"))) (duty ((Occupation "King Of Camelot")))))                        
```                            
As you can see it returns a list with a similar structure to the xml file.
