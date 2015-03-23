#lang racket

;; **********************************************************************
;; * - Name: Roy Van Liew
;; * - Section: 91.301.201 - Organization of Programming Languages
;; * - FP1: BOTTLENOSE PERL TESTS TO RACKET TEST CONVERTER
;; *   This script takes in a perl bottlenose test script file, usually
;; *   labeled test.t, and then changes the perl tests into Racket
;; *   test cases to be run in either the RackUnit GUI or
;; *   textual interface. That script must be run separately.
;; **********************************************************************

(require racket/file)
(define nil '())

;; **********************************************************************
;; * Selectors for finding certain parts of the perl test case
;; **********************************************************************

;; The perl tests start with "ok".
(define (is-test? line)
  (if (regexp-match #rx"^\\s*ok.*" line) #t #f))

;; Gets first test input part of the line to parse in regexp in find-test-input
(define (get-test-input line)
  (car (string-split line ",")))

;; Gets second expected value part of the line to parse in regexp in find-expected-value
(define (get-expected-value line)
  (cadr (string-split line ",")))

;; Gets third test name part of the line to parse in regexp in find-test-name
(define (get-test-name line)
  (caddr (string-split line ",")))

;; **********************************************************************
;; * Constructors for removing unnecessary parts of the perl test case
;; **********************************************************************

;; first-test for scheme test inputs
(define (find-test-input line)
  ;; Opening parentheses, followed by zero or more whitespaces, followed by \ and ",
  ;; followed by zero or more whitespaces, everything in between is the test input,
  ;; followed by zero or more whitespaces, followed by \ and ", followed by zero or more
  ;; whitespaces, followed by a closing parentheses.
  (define expected (regexp-match #rx"\\(\\s*\\\"\\s*(.*)\\s*\\\"\\s*\\)" line))
  (if (not (equal? expected #f))
      (string-trim (cadr expected))
      #f))

;; second-test for expected values
(define (find-expected-value line)
  (define expected (regexp-match #rx"^\\s*(.*)\\)$" line))
  (if (not (equal? expected #f))
      (string-trim (cadr expected))
      #f))

;; third-test for test names
(define (find-test-name line)
  ;; Zero or more whitespaces, followed by \ and ",
  ;; followed by zero or more whitespaces, everything in between is the test input,
  ;; followed by zero or more whitespaces, followed by \ and ", followed by zero or more
  ;; whitespaces, followed by a closing parentheses.
  (define expected (regexp-match #rx"\\s*\\\"\\s*(.*)\\s*\\\"\\s*\\)" line))
  (if (not (equal? expected #f))
      (string-trim (cadr expected))
      #f))

;; **********************************************************************
;; * Procedures for retrieving all test inputs, expected values, and
;; * test names in a bottlenose perl file.
;; **********************************************************************

(define (zip . seq)
  (define (helper seq)
    (if (equal? nil (car seq))
        nil
        (cons (map car seq) (helper (map cdr seq)))))
  (helper seq)
)

(define (get-all-test-inputs all-lines)
  (map find-test-input (map get-test-input (filter is-test? all-lines))))

(define (get-all-expected-values all-lines)
  (map find-expected-value (map get-expected-value (filter is-test? all-lines))))

(define (get-all-test-names all-lines)
  (map find-test-name (map get-test-name (filter is-test? all-lines))))

(define (get-all-test-information all-lines)
  (zip (get-all-test-inputs file-lines)
       (get-all-expected-values file-lines)
       (get-all-test-names file-lines)))

;; **********************************************************************
;; * Procedures for creating strings representing what we want to write
;; * out to our suite file for the test cases inside the test suite.
;; **********************************************************************

(define (create-test-case sublist)
  (define sym-to-number (regexp-match #rx"'(.*)'" (cadr sublist)))
  (if (not (equal? sym-to-number #f))
      (string-append "  (test-case \"" (caddr sublist) "\" (check-equal? " (car sublist) " " (cadr sym-to-number) "))")
      (string-append "  (test-case \"" (caddr sublist) "\" (check-equal? " (car sublist) " " (cadr sublist) "))")))

(define (test-cases-to-one-string current test-cases)
  (if (null? test-cases)
      current
      (test-cases-to-one-string (string-append current (car test-cases)) (cdr test-cases))))

(define (create-test-suite suite-name test-cases)
  (define suite-header (list ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
                             (string-append "(define-test-suite " suite-name)
                             (string-append "  #:before (lambda () (display \"Starting Test Suite '" suite-name "'\\n\"))")
                             (string-append "  #:after (lambda () (display \"Finished Test Suite '" suite-name "'\\n\"))")))
  (define header-with-tests (append suite-header (map create-test-case test-cases)))
  (define suite-to-return (append header-with-tests (list ")\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n")))
  suite-to-return
)

;; **********************************************************************
;; * Test Suite File Creation Procedures
;; **********************************************************************

(define (remake-file file-path)
(if (file-exists? file-path)
    (delete-file file-path)
    0))

;; Create header of the suite file
(define (make-suite-header assignment-name)
  (define rkt-header (list "#lang racket\n"
                           "(require rackunit)"
                           (string-append "(require \"" assignment-name ".rkt\")\n")))                
  rkt-header
)

;; Create test-list for this bottlenose suite
(define (create-suite-string sublist)
  (string-append "  " sublist))

;; suite-names is a list of the suite names we're creating.
(define (create-test-suite-list suite-names)
  (define test-list-define (list "(define test-list (list"))
  (define test-suite-list (map create-suite-string suite-names))
  (define define-with-suites (append test-list-define test-suite-list (list "))\n")))
  (define footer-to-return (append define-with-suites (list "(provide (all-defined-out))\n")))
  footer-to-return
)

;; Now we need a procedure that can write these lines out to a file
(define (write-suite-file lines suite-name)
  (define placeholder (remake-file (string-append suite-name "_suite.rkt")))
  (display-lines-to-file lines (string-append suite-name "_suite.rkt") #:separator"\n"))

;; **********************************************************************
;; * Test Area File Creation Procedures
;; **********************************************************************

(define (gui-or-text test-mode)
  (cond ((equal? test-mode "make-gui-runner")
         (list ";; map is used here to allow each test suite to appear in the same GUI window."
               "(map (make-gui-runner) test-list)\n"))
        ((equal? test-mode "run-tests")
         (list ";; map is used here to allow each test suite to be run in the textual interface."
               "(map run-tests test-list)\n"))
        (else nil)) ;; end cond
) ;; end define
        

(define (create-test-area-lines assignment-name test-mode)
  (define rkt-header (list "#lang racket\n"
                           ";; Racket Unit Testing Libraries"
                           "(require racket/include)"
                           "(require rackunit)"
                           "(require rackunit/text-ui)"
                           "(require rackunit/gui)\n"
                           ";; Suite file for this assignment"
                           (string-append "(require \"" assignment-name "_suite.rkt\")\n")))
  (define gui-or-text-lines (gui-or-text test-mode))
  (define test-area-lines (append rkt-header gui-or-text-lines (list "\n(provide (all-defined-out))\n")))
  test-area-lines
)

;; Now we need a procedure that can write these lines out to a file
(define (write-area-file lines suite-name)
  (define placeholder (remake-file (string-append suite-name "_area.rkt")))
  (display-lines-to-file lines (string-append suite-name "_area.rkt") #:separator"\n"))

;; **********************************************************************
;; * MAIN
;; **********************************************************************

;; We first need our assignment name. Edit assn-name to reflect the specific one e.g. ps1, ps2, so forth
;; Also note that file-lines here reads in every line from the perl test file. Edit this to reflect the specific one.
(define file-lines (file->lines "test.t"))
(define assn-name "ps1")

;; Get a list of all the "ok" test lines in the perl file
(define all-tests (get-all-test-information file-lines))

;; Get the list of strings to write out to the suites file for this assignment test file.
(define suite-file-header (make-suite-header assn-name))
(define bottlenose-suite (create-test-suite assn-name all-tests))
(define suite-file-footer (create-test-suite-list (list assn-name)))

;; Create the full lists that are needed to write out to both the test suite and test area files.
;; The mode to pass to create-test-area-lines should be one of "make-gui-runner" or "run-tests"
(define scheme-suite-file-lines (append suite-file-header bottlenose-suite suite-file-footer))
(define scheme-area-file-lines (create-test-area-lines assn-name "make-gui-runner"))

;; To write out to the suite and area files, using the following two calls:
(write-suite-file scheme-suite-file-lines assn-name)
(write-area-file scheme-area-file-lines assn-name)
;; Please note that the perl test file and the original source file for the assignment
;; where the procedure definitions are in the same directory as this script. So for instance
;; test.t and ps1.rkt should be in this script's same directory if we are working on ps1, and
;; assn-name should be "ps1" in that case. Also, REMEMBER TO PUT THE PROVIDE STATEMENT AT
;; THE END OF THE SOURCE FILE.
;; (provide (all-defined-out))
