(defun cmplmnt (fn)
  #'(lambda (&rest args) (not (apply fn args))))


;; (remove-if (cmplmnt #'oddp) '(1 2 3 4 5 6)) ;=> (1 3 5)
;;



; # Returning Destructive Elements

;; (defvar *!equivs* (make-hash-table))

;; (defun ! (fn)
;;   (or (gethash fn *!equivs*) fn))

;; (defun def! (fn fn!)
;;   (setf (gethash fn *!equivs*) fn!))

;; (def! #'remove-if #'delete-if)

;; instead of (delete-if #'oddp lst)
;; we would say (funcall (! #'remove-if) #'oddp lst)
w

;Memoizing utility
(defun memoize (fn)
  (let ((cache (make-hash-table :test #'equal)))
    #'(lambda (&rest args)
        (multiple-value-bind (val win) (gethash args cache)
          (if win
              val
              (setf (gethash args cache)
                    (apply fn args)))))))


;; (setq slowid (memoize #'(lambda (x) (sleep 5) x)))

;; (time (funcall slowid 1));; 5.15 seconds

;; (time (funcall slowid 1));; 0.00 seconds



;; Composing Functions

(defun compose (&rest fns)
  (if fns
      (let ((fn1 (car (last fns)))
            (fns (butlast fns)))
        #'(lambda (&rest args)
            (reduce #'funcall fns :from-end t
                    :initial-value (apply fn1 args))))
      #'identity))

;; eg (compose #'list #'1+) returns a fx equivalent to #'(lambda (x) (list (1+ x)))
;; (funcall (compose #'1+ #'find-if) #'oddp '(2 3 4)) ;==> 4


; More function builders

(defun fif (if then &optional else)
  #'(lambda (x)
  (if (funcall if x)
      (funcall then x)
    (if else (funcall else x)))))


(defun fint (fn &rest fns)
  fn
  (let ((chain (apply #'fint fns)))
    #'(lambda (x)
        (and (funcall fn x) (funcall chain x))))
  )

(defun fun (fn &rest fns)
  if (null fns)
  fn
  (let ((chain (apply #'fun fns)))
    #'(lambda (x)
        (or (funcall fn x) (funcall chain x)))))
