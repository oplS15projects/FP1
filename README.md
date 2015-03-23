# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

### My Libraries: RackUnit and Filesystem

For this first solo project I used the RackUnit API which provides both a GUI and textual user interface for displaying test case results. As a QA Engineer at my first co-op with Akamai, a Regression Harness was used to see if changes to a code's functionality made some test cases fail -- in which case the software regressed. The bottlenose tests are similar in this aspect in that they are test cases that try out different inputs and compare the actual results from the student's implementation to the expected results from the test case in the perl script. However, I noticed that having just the perl script would mean you'd test each case once at a time manually, and if you made changes to your code's functionality you couldn't immediately see if it broke another test case.

My project takes these bottlenose perl scripts and converts them into Racket test cases to be run in the RackUnit API. This way you can easily source your file that has all the procedure definitions and test your code. My script can change the perl tests into a Racket file with a test suite with test cases for that specific assignment, and then also create a Racket file that can run this test suite in either the GUI or the textual interface. This way a student can easily make a change in the source file and see what difference makes not for one test case at a time manually, but all test cases at once. In my script you can specify the assignment name, the name of the bottlenose perl test file (usually test.t), and testing mode (GUI or text).

So for example, the following bottlenose perl test case would be this:
```
ok(scm_equal(scm_eval("(abs-using-cond -3)"), 3), "(abs-using-cond -3)");
```

Then my script would change that test case to this:
```
(test-case "(abs-using-cond -3)" (check-equal? (abs-using-cond -3) 3))
```
 
More specifically, these were the relevant require statements for the libraries I used.
* `(require racket/file)`
* `(require rackunit)`
* `(require rackunit/text-ui)`
* `(require rackunit/gui)`

### Script

To see the code I wrote for this converter, [see **bottlenose_to_racket.rkt**][bottle-rkt]. I've commented the code in a way that splits up the different parts of its functionality, and hopefully it is able to guide the reader as to how it works.
 
I can however give a high level overview of what this script does.
* Read in all lines from the bottlenose perl test script.
* Obtain all the test cases in the perl test script and convert them to Racket test cases.
* Create a list of strings that represent what to write out to the Racket file containing the test suite.
* Create a list of strings that represent what to write out to the Racket file containing the test area (the script that runs the test cases).
* `display-lines-to-file` is used to write these strings out to the test suite and test area files.

If you want better explanations, go on over to the Explanations section.

### Output

I will specify what parameters were used in the following output pictures. In my case I ran this script on ps1's test.t file.

##### GUI Runner
* `(define file-lines (file->lines "test.t"))`
* `(define assn-name "ps1")`
* `(define scheme-area-file-lines (create-test-area-lines assn-name "make-gui-runner"))`

##### Textual Interface
* `(define file-lines (file->lines "test.t"))`
* `(define assn-name "ps1")`
* `(define scheme-area-file-lines (create-test-area-lines assn-name "run-tests"))`

#### Running the script

1. Before the script is run, you only have the assignment source file, the perl test file, and the converter script in the same directory. [Here is a **picture** showing the starting files][before-script-1].

2. After the script is run, the suite and area file are generated. [Here is a **picture** including the generated files][after-script-2].

3. If you specified `"make-gui-runner"` as the test mode, you get a nice [**GUI** window][gui-script-3].

4. If you specified `"run-tests"` as the test mode, you get the [**textual** interface][text-script-3].

### Explanations

This section goes over the define statements you see in the MAIN of the script.

#### all-tests
* A list with sublists containing three elements: input, expected value, and name for each test case.
* In `get-all-test-information`, `zip` is used here to line up the input, expected value, and name for each test in parallel.
```
'(("(square 3)" "9" "(square 3)")
  ("(square 1)" "1" "(square 1)")
  ("(abs-using-if 0)" "0" "(abs-using-if 0)")
  ("(abs-using-if 1)" "1" "(abs-using-if 1)")
  ("(abs-using-if -3)" "3" "(abs-using-if -3)")
  ("(abs-using-cond 0)" "0" "(abs-using-cond 0)")
  ("(abs-using-cond 1)" "1" "(abs-using-cond 1)")
  ("(abs-using-cond -3)" "3" "(abs-using-cond -3)")
  ("(fact 1)" "1" "(fact 1)")
  ("(fact 5)" "120" "(fact 5)")
  ("(fact 20)" "2432902008176640000" "(fact 20)")
  ("(comb 3 2)" "3" "(comb 3 2)")
  ("(comb 4 2)" "6" "(comb 4 2)")
  ("(comb 10 2)" "45" "(comb 10 2)")
  ("(comb 93 37)" "'118206769052646517220135262'" "(comb 93 37)")
  ("(triple 0)" "0" "(triple 0)")
  ("(triple 5)" "15" "(triple 15)")
  ("(triple -1)" "-3" "(triple -1)")
  ("(diff-of-triples 1 0)" "3" "(diff-of-triples 1 0)")
  ("(diff-of-triples 3 1)" "6" "(diff-of-triples 3 1)")
  ("(diff-of-triples 10 2)" "24" "(diff-of-triples 10 2)")
  ("(smallest-of-three 1 2 3)" "1" "(smallest-of-three 1 2 3)")
  ("(smallest-of-three 2 1 3)" "1" "(smallest-of-three 2 1 3)")
  ("(smallest-of-three 3 2 1)" "1" "(smallest-of-three 3 2 1)")
  ("(smallest-of-three 1 1 2)" "1" "(smallest-of-three 1 1 2)")
  ("(smallest-of-three -1 -1 0)" "-1" "(smallest-of-three -1 -1 0)")
  ("(smallest-of-three 1 1 1)" "1" "(smallest-of-three 1 1 1)")
  ("(smallest-tripled 1 2 3)" "3" "(smallest-tripled 1 2 3)")
  ("(smallest-tripled -1 -1 0)" "-3" "(smallest-tripled -1 -1 0)")
  ("(smallest-tripled 30 20 10)" "30" "(smallest-tripled 30 20 10)"))
```

#### suite-file-header
* A list of strings representing lines to write at the top of the suite file.
* `make-suite-header` allows the require statement of the assignment source file to be generalized.
```
'("#lang racket\n" "(require rackunit)" "(require \"ps1.rkt\")\n")
```

#### bottlenose-suite
* A list of strings representing lines to write in the middle of the suite file.
* `create-test-suite` takes the assignment name and `all-tests` to write out the big part of the suite file.
```
'(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  "(define-test-suite ps1"
  "  #:before (lambda () (display \"Starting Test Suite 'ps1'\\n\"))"
  "  #:after (lambda () (display \"Finished Test Suite 'ps1'\\n\"))"
  "  (test-case \"(square 3)\" (check-equal? (square 3) 9))"
  "  (test-case \"(square 1)\" (check-equal? (square 1) 1))"
  "  (test-case \"(abs-using-if 0)\" (check-equal? (abs-using-if 0) 0))"
  "  (test-case \"(abs-using-if 1)\" (check-equal? (abs-using-if 1) 1))"
  "  (test-case \"(abs-using-if -3)\" (check-equal? (abs-using-if -3) 3))"
  "  (test-case \"(abs-using-cond 0)\" (check-equal? (abs-using-cond 0) 0))"
  "  (test-case \"(abs-using-cond 1)\" (check-equal? (abs-using-cond 1) 1))"
  "  (test-case \"(abs-using-cond -3)\" (check-equal? (abs-using-cond -3) 3))"
  "  (test-case \"(fact 1)\" (check-equal? (fact 1) 1))"
  "  (test-case \"(fact 5)\" (check-equal? (fact 5) 120))"
  "  (test-case \"(fact 20)\" (check-equal? (fact 20) 2432902008176640000))"
  "  (test-case \"(comb 3 2)\" (check-equal? (comb 3 2) 3))"
  "  (test-case \"(comb 4 2)\" (check-equal? (comb 4 2) 6))"
  "  (test-case \"(comb 10 2)\" (check-equal? (comb 10 2) 45))"
  "  (test-case \"(comb 93 37)\" (check-equal? (comb 93 37) 118206769052646517220135262))"
  "  (test-case \"(triple 0)\" (check-equal? (triple 0) 0))"
  "  (test-case \"(triple 15)\" (check-equal? (triple 5) 15))"
  "  (test-case \"(triple -1)\" (check-equal? (triple -1) -3))"
  "  (test-case \"(diff-of-triples 1 0)\" (check-equal? (diff-of-triples 1 0) 3))"
  "  (test-case \"(diff-of-triples 3 1)\" (check-equal? (diff-of-triples 3 1) 6))"
  "  (test-case \"(diff-of-triples 10 2)\" (check-equal? (diff-of-triples 10 2) 24))"
  "  (test-case \"(smallest-of-three 1 2 3)\" (check-equal? (smallest-of-three 1 2 3) 1))"
  "  (test-case \"(smallest-of-three 2 1 3)\" (check-equal? (smallest-of-three 2 1 3) 1))"
  "  (test-case \"(smallest-of-three 3 2 1)\" (check-equal? (smallest-of-three 3 2 1) 1))"
  "  (test-case \"(smallest-of-three 1 1 2)\" (check-equal? (smallest-of-three 1 1 2) 1))"
  "  (test-case \"(smallest-of-three -1 -1 0)\" (check-equal? (smallest-of-three -1 -1 0) -1))"
  "  (test-case \"(smallest-of-three 1 1 1)\" (check-equal? (smallest-of-three 1 1 1) 1))"
  "  (test-case \"(smallest-tripled 1 2 3)\" (check-equal? (smallest-tripled 1 2 3) 3))"
  "  (test-case \"(smallest-tripled -1 -1 0)\" (check-equal? (smallest-tripled -1 -1 0) -3))"
  "  (test-case \"(smallest-tripled 30 20 10)\" (check-equal? (smallest-tripled 30 20 10) 30))"
  ")\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n")
```

#### suite-file-footer
* A list of strings representing lines to write at the bottom of the suite file.
* `create-test-suite-list` determines what the `test-list` definition will be. This is the suite list that will be run in the area file.
```
'("(define test-list (list" "  ps1" "))\n" "(provide (all-defined-out))\n")
```

#### scheme-suite-file-lines
* A list of strings representing all lines to write out to the test suite file.
```
'("#lang racket\n"
  "(require rackunit)"
  "(require \"ps1.rkt\")\n"
  ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  "(define-test-suite ps1"
  "  #:before (lambda () (display \"Starting Test Suite 'ps1'\\n\"))"
  "  #:after (lambda () (display \"Finished Test Suite 'ps1'\\n\"))"
  "  (test-case \"(square 3)\" (check-equal? (square 3) 9))"
  "  (test-case \"(square 1)\" (check-equal? (square 1) 1))"
  "  (test-case \"(abs-using-if 0)\" (check-equal? (abs-using-if 0) 0))"
  "  (test-case \"(abs-using-if 1)\" (check-equal? (abs-using-if 1) 1))"
  "  (test-case \"(abs-using-if -3)\" (check-equal? (abs-using-if -3) 3))"
  "  (test-case \"(abs-using-cond 0)\" (check-equal? (abs-using-cond 0) 0))"
  "  (test-case \"(abs-using-cond 1)\" (check-equal? (abs-using-cond 1) 1))"
  "  (test-case \"(abs-using-cond -3)\" (check-equal? (abs-using-cond -3) 3))"
  "  (test-case \"(fact 1)\" (check-equal? (fact 1) 1))"
  "  (test-case \"(fact 5)\" (check-equal? (fact 5) 120))"
  "  (test-case \"(fact 20)\" (check-equal? (fact 20) 2432902008176640000))"
  "  (test-case \"(comb 3 2)\" (check-equal? (comb 3 2) 3))"
  "  (test-case \"(comb 4 2)\" (check-equal? (comb 4 2) 6))"
  "  (test-case \"(comb 10 2)\" (check-equal? (comb 10 2) 45))"
  "  (test-case \"(comb 93 37)\" (check-equal? (comb 93 37) 118206769052646517220135262))"
  "  (test-case \"(triple 0)\" (check-equal? (triple 0) 0))"
  "  (test-case \"(triple 15)\" (check-equal? (triple 5) 15))"
  "  (test-case \"(triple -1)\" (check-equal? (triple -1) -3))"
  "  (test-case \"(diff-of-triples 1 0)\" (check-equal? (diff-of-triples 1 0) 3))"
  "  (test-case \"(diff-of-triples 3 1)\" (check-equal? (diff-of-triples 3 1) 6))"
  "  (test-case \"(diff-of-triples 10 2)\" (check-equal? (diff-of-triples 10 2) 24))"
  "  (test-case \"(smallest-of-three 1 2 3)\" (check-equal? (smallest-of-three 1 2 3) 1))"
  "  (test-case \"(smallest-of-three 2 1 3)\" (check-equal? (smallest-of-three 2 1 3) 1))"
  "  (test-case \"(smallest-of-three 3 2 1)\" (check-equal? (smallest-of-three 3 2 1) 1))"
  "  (test-case \"(smallest-of-three 1 1 2)\" (check-equal? (smallest-of-three 1 1 2) 1))"
  "  (test-case \"(smallest-of-three -1 -1 0)\" (check-equal? (smallest-of-three -1 -1 0) -1))"
  "  (test-case \"(smallest-of-three 1 1 1)\" (check-equal? (smallest-of-three 1 1 1) 1))"
  "  (test-case \"(smallest-tripled 1 2 3)\" (check-equal? (smallest-tripled 1 2 3) 3))"
  "  (test-case \"(smallest-tripled -1 -1 0)\" (check-equal? (smallest-tripled -1 -1 0) -3))"
  "  (test-case \"(smallest-tripled 30 20 10)\" (check-equal? (smallest-tripled 30 20 10) 30))"
  ")\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"
  "(define test-list (list"
  "  ps1"
  "))\n"
  "(provide (all-defined-out))\n")
```

#### scheme-area-file-lines
* A list of strings representing all lines to write out to the test area file.
```
'("#lang racket\n"
  ";; Racket Unit Testing Libraries"
  "(require racket/include)"
  "(require rackunit)"
  "(require rackunit/text-ui)"
  "(require rackunit/gui)\n"
  ";; Suite file for this assignment"
  "(require \"ps1_suite.rkt\")\n"
  ";; map is used here to allow each test suite to appear in the same GUI window."
  "(map (make-gui-runner) test-list)\n"
  "\n(provide (all-defined-out))\n")
```

At this point you see how the line formatting will work in the output files. These files have everything they need to know about how to run the tests. The limitation is that the original source file (in this case, ps1.rkt) needs to have the provide statement at the end of it or the script will come up with unbound identifier errors. A `(provide (all-defined-out))` statement at the end of the source file will fix this problem.
  
<!-- Links -->
[bottle-rkt]: https://github.com/Dossar/FP1/blob/master/bottlenose_to_racket.rkt
[before-script-1]: https://raw.githubusercontent.com/Dossar/FP1/master/gui_test/pt1.png
[after-script-2]: https://raw.githubusercontent.com/Dossar/FP1/master/gui_test/pt2.png
[gui-script-3]: https://raw.githubusercontent.com/Dossar/FP1/master/gui_test/pt3_gui.png
[text-script-3]: https://raw.githubusercontent.com/Dossar/FP1/master/gui_test/pt3_text.png
