; Functions which search lists
(defun find2 (fn lst)
  (if (null lst)
      nil
      (let ((val (funcall fn (car lst))))
        (if val
            (values (car lst) val)
            (find2 fn (cdr lst))))))

(defun before (x y lst &key (test #'eql))
  (and lst
       (let ((first (car lst)))
         (cond ((funcall test y first) nil)
               ((funcall test x first) lst)
               (t (before x y (cdr lst) :test test))))))
;;; (before 'a 'b '(a)) ; ==> (A)

(defun after (x y lst &key (test #'eql))
  (let ((rest (before y x lst :test test)))
    (and rest (member x rest :test test))))
;;; (after 'a 'b '(b a d)); ==> (A D)
;;; (after 'a 'b '(a)) ; ==> NIL

;; Check whether list lst contains duplicate obj using some test default
;; equality
(defun duplicate (obj lst &key (test #'eql))
  (member obj (cdr (member obj lst :test test))
          :test test))

;;; (duplicate 'a '(a b c a d)) ;==> (A D)

(defun split-if (fn lst)
  (let ((acc nil))
    (do ((src lst (cdr src)))
        ((or (null src) (funcall fn (car src)))
         (values (nreverse acc) src))
      (push (car src) acc))))

;;; (split-if #'(lambda (x) (> x 4))
; '(1 2 3 4 5 6 7 8 9 10))
;;; =>  (1 2 3 4)
;;; =>  (5 6 7 8 9 10)

; Search Functions which compare elements

(defun most (fn lst)
  (if (null lst)
      (values nil nil)
      (let* ((wins (car lst))
             (max (funcall fn wins)))
        (dolist (obj (cdr lst))
          (let ((score (funcall fn obj)))
            (when (> score max)
              (setq wins obj max score))))
        (values wins max))))
(most #'length '((a b) (a b c) (a) (e f g))) ;==> (A B C) ;===> 3

(defun best (fn lst)
  (if (null lst)
      nil
      (let ((wins (car lst)))
        (dolist (obj (cdr lst))
          (if (funcall fn obj wins)
              (setq wins obj)))
        wins)))

(best #'> '(1 2 3 4 5)) ; ==> 5

(defun mostn (fn lst)
  (if (null lst)
      (values nil nil)
      (let ((result (list (car lst)))
            (max (funcall fn (car lst))))
        (dolist (obj (cdr lst))
          (let ((score (funcall fn obj)))
            (cond ((> score max)
                   (setq max score result (list obj)))
                  ((= score max)
                   (push obj result)))))
        (values (nreverse result) max))))


(mostn #'length '((ab) (a b c) (a) (e f g))) ;==>((A B C) (E F G)) ; ==> 3
