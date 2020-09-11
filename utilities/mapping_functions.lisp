;; Another widely used class of Lisp functions are the mapping functions which
;; apply a function to a sequence of arguments.
;; both map0-n and map1-n are written using the general form mapa-b, which works
;; for any range of numbers and not only for ranges of positive integers
(defun mapa-b (fn a b &optional (step 1))
  (do ((i a (+ i step))
       (result nil))
      ((> i b) (nreverse result))
    (push (funcall fn i) result)))


;; (mapa-b #'1+ -2 0 .5);====> (-1 -0.5 0.0 0.5 1.0)



(defun map0-n (fn n)
  (mapa-b fn 0 n))

(defun map1-n (fn n)
  (mapa-b fn 1 n))


;; (map0-n #'1+ 5); ===> (1 2 3 4 5 6)

;; (map1-n #'1+ 5); ===> (2 3 4 5 6)

(defun map-> (fn start test-fn succ-fn)
  (do ((i start (funcall succ-fn i))
       (result nil))
      ((funcall test-fn i) (nreverse result))
    (push (funcall fn i) result)))

(defun mappend (fn &rest lsts)
  (apply #'append (apply #'mapcar fn lsts)))

;; The utility mapcars is for cases where we want to mapcar a function over
;; several lists. If we have two lists of numbers and we want to get a single
;; list of the square roots of both we could say in raw lisp (mapcar #'sqrt
;; (append list1 list2)) or using mapcars
(defun mapcars (fn &rest lsts)
  (let ((result nil))
    (dolist (lst lsts)
      (dolist (obj lst)
        (push (funcall fn obj) result)))
    (nreverse result)))

;; (mapcars #'sqrt '(1 2 4 6 7 9) '( 25 81 625 225))

;; Recursive mapcar a version of mapcar for trees and does what mapcar does on
;; flat lists, it does on trees
(defun rmapcar (fn &rest args)
  (if (some #'atom args)
      (apply fn args)
      (apply #'mapcar
             #'(lambda (&rest args)
                 (apply #'rmapcar fn args))
             args)))
;; (rmapcar #'sqrt '(1 2 4 6 7 9 ( 25 81 625 225)))
