


;;For the case where you want users to be able to type in expressions without
;;parenthenses; it reads a line of input and returns it as a list
(defun readlist (&rest args)
  (values (read-from-string
            (concatenate 'string "("
                         (apply #'read-line args)
                         ")"))))

; (readlist)
;;; call me "Ed"
;;;=> (CALL ME "Ed")

;; The function prompt combines printing a question and reading the answer.It
;; takes the arguments of format,except the initial stream argument
(defun prompt (&rest args)
  (apply #'format *query-io* args)
  (read *query-io*))

; (prompt "Enter a number between ~A and ~A. ~%>> " 1 10)
;;;>>> 3
;;; => 3


;; break-loop is for situations where you want to imitate the Lisp toplevel.
;;It takes 2 functions and an &rest argument,which is repeatedly given to
;;prompt. As long as the second function returns false for the input, the first
;;function is aplied to it
(defun break-loop (fn quit &rest args)
  (format *query-io* "Entering break-loop ~%")
  (loop
    (let ((in (apply #'prompt args)))
      (if (funcall quit in)
          (return)
          (format *query-io* "~A~%" (funcall fn in))))))

; (break-loop #'eval #'(lambda (x) (eq x :q)) ">> ")
;;=> Entering break-loop.
;;;>> (+ 2 3)
;;;=> 5
;;; >> :q
;;;=> :Q
