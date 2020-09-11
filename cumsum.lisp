(defun cumsum (lst &key (smsf 0))
  " Calculate the Cumulative Sum of a List `lst'. and return a new list with the incremental sums at each step.  (`cumsum' '(1 3 4 6 8) :smsf 0) where `:smsf' is an optional parameter specifying where to start summing from. i.e the offset of counting."
  (if (null lst)
      '()
    (cons (+ smsf (car lst))
          (funcall #'cumsum (cdr lst) :smsf (+ smsf (car lst))))))

(cumsum '(1 2 3 4 5 6 7 8 9 10))

(cumsum '(1 2 3 4 5 6 7 8 9 10) :smsf 1)
