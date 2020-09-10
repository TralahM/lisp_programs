; Named Functions:defun
; creating named functions is done with the defun keyword. It follows this mode
; (defun <name> (list of arguments)
; "docstring"
; (function body))

;; example
(defun greet ()
  "greet function"
  (print "Greetings!"))
;;; (greet)

;; Arguments
(defun greeta (name)
  "Greet a `name."
  (format t "hello ~a ! ~&"))
;; where ~a is the most used format directive to print a variable aesthetically
;; and ~& prints a new line
;;; (greeta "Himself")

;; Optional arguments: &optional
(defun hello (name &optional age gender)
  (format "Hello ~a ! ~&" name ))

;; Named Parameters: &key
(defun helloa (name &key happy)
  "If `happy` is `t', print a smiley"
  (format t "hello ~a " name)
  (when happy
    (format t ":)~&")))
;;; (hello "me")
;;; (hello "me" :happy t)
;;; Several key parameters: (defun hellob (name &key happy lisper
;;; cookbook-contributor-p) ...)

;; Default values

(defun helloc (name &key (happy t))
  (format t "Hello ~a :)~&" name))

;; Variable number of arguments: &rest
;;; sometime you want a function to accept a variable number of arguments. Use
;;; &rest <variable>, where variable will be a list.
(defun mean (x &rest numbers)
  (/ (apply #'+ x numbers)
     (1+ (length numbers))))
;;; (mean 1)
;;; (mean 1 2)
;;; (mean 1 3 4 5 6 7 8)

; &allow-other-keys ===> Equivalent to python's **kwargs
(defun hellokwargs (name &key happy &allow-other-keys)
  (format t "hello ~a~&" name))

;;example
(defun open-supersede (f &rest other-keys &key &allow-other-keys)
  (apply #'open f :if-exists :supersede other-keys))

;; multiple return values: values, multiple-value-bind and nth-value

(defun foo (a b c)
  (values a b c))

;;; We destructure multiple values with multiple-value-bind and we can get one
;;; given its position with nth-value
(multiple-value-bind (res1 res2 res3)
    (foo :a :b :c)
  (format t "res1 is ~a, res2 is ~a, res3 is ~a~&" res1 res2 res3))

(nth-value 2 (values :a :b :c)) ;; => :C
;;; multiple-value-list turns multiple values to a list the reverse is
(multiple-value-list (values 1 2 3))
;;; values-list which turns a list into multiple values
(values-list '(1 2 3))


; Anonymous Functions: lambda, funcall, apply
((lambda (x) (print x)) "hello")
(funcall #'+ 1 2 )
(apply #'+ '(1 2))


; Higher order functions:functions that return functions
(defun adder (n)
  (lambda (x) (+ x n)))
;; (adder 5) => CLOSURE (LAMBDA (X) IN ADDER)
(funcall (adder 5) 3) ; 8

(boundp 'foo)
(fboundp 'foo)

(setf (symbol-function '*myfunc*) (adder 3))
(fboundp '*myfunc*) ; => T
(*myfunc* 4) ; => 7


; setf functions ===> a function name can also be a list of two symbols with
; setf as the furst one, and where the first argument if the new value.
;; (defun (setf <name>) (new-value <other arguments>) body)

;; Example ;; particularly used by CLOS methods.
(defparameter *current-name* ""
  "A global name.")
(defun hellof (name)
  (format t "hello ~a~&" name))

(defun (setf hellof) (new-value)
  (hello new-value)
  (setf *current-name* new-value)
  (format t "current name is now ~a~&" new-value))

(setf (hello) "Alice")

; Currying
(defun curry (function &rest args)
  (lambda (&rest more-args)
    (apply function (append args more-args))))
(funcall (curry #'+ 3) 5) ;===> 8
(funcall (curry #'+ 3) 6) ;===> 9
(setf (symbol-function 'power-of-ten) (curry #'expt 10))
(power-of-ten 3) ; ===> 1000


; With the alexandria library
(ql:quickload :alexandria)
(defun adder (foo bar)
  "Add the two arguments."
  (+ foo bar))

(defvar add-one (alexandria:curry #'adder 1) "Add 1 to the argument.")
(funcall add-one 10) ;; => 11
(setf (symbol-function 'add-one) add-one)
(add-one 10) ;; => 11
