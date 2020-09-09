;Function definition, closures,scope,#'functions

(defun dbl (x) (* x 2))

(defun add-two (x) (mapcar #'(lambda (x) (+ 2 x)) x))

(let ((counter 0))
  (defun new-id () (incf counter))
  (defun reset-id () (setq counter 0)))

(print (remove-if #'evenp '(1 2 3 4 5 6 7 8 9 10)))

(print (add-two '(43 34)))
(print (mapcar #'(lambda (x) (+ x 10)) '(1 2 3)))
(print (dbl 322))
(print "Hello TralahTek")
(print (dbl 29))
