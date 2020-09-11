;Functions which operate on symbols and strings

; Symbols and strings are closely related.By means of priinting and reading
; functions we can go back and forth between the two representation.


;; The first,mkstr takes any number of arguments and concatenates their printed
;; representations into a string:
;;; Built upon symb

(defun mkstr (&rest args)
  (with-output-to-string (s)
    (dolist (a args) (princ a s))))


(mkstr pi " pieces of " 'pi) ;===> "3.141592653589793 pieces of PI"

(defun symb (&rest args)
  (values (intern (apply #'mkstr args))))

;; Generalization of symb it takes a series of objects,prints and rereads them.
;; it can return symbols like symb,but it can also return anything else read can
(defun reread (&rest args)
  (values (read-from-string (apply #'mkstr args))))


;; takes a symbol and returns a list of symbols made from the characters in
;; its name
(defun explode (sym)
  (map 'list #'(lambda (c)
                 (intern (make-string 1 :initial-element c)))
       (symbol-name sym)))

(explode 'bomb);==> (B O M B)

(explode 'tralahtek)
