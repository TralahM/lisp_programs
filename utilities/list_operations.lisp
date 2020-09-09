; Utility Functions for Operations on Lists
; Author: Tralah M Brian
;
; Copyright © 2020 Tralah M Brian

; Permission is hereby granted, free of charge, to any person obtaining
; a copy of this software and associated documentation files (the "Software"),
; to deal in the Software without restriction, including without limitation
; the rights to use, copy, modify, merge, publish, distribute, sublicense,
; and/or sell copies of the Software, and to permit persons to whom the
; Software is furnished to do so, subject to the following conditions:

; The above copyright notice and this permission notice shall be included
; in all copies or substantial portions of the Software.

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
; DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
; OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

; Small Functions which operate on lists

(proclaim '(inline last1 single append1 conc1 mklist))

;; last element in a list
(defun last1 (lst) (car (last lst)))

;; test whether lst is a list of one element
(defun single (lst) (and (consp lst) (not (cdr lst))))

;; attach a new element to end of a list non-destructively
(defun append1 (lst obj) (append lst (list obj)))

;; attach a new element to end of a list destructively
(defun conc1 (lst obj) (nconc lst (list obj)))

;; Ensure obj is a list
(defun mklist (obj) (if (listp obj) obj (list obj)))


; Longer Functions That Operate on Lists

;; Check whether a list x is longer than a list y
(defun longer (x y)
  (labels ((compare (x y)
                    (and (consp x) (or (null y)
                                       (compare (cdr x) (cdr y))))))
    (if (and (listp x) (listp y)) (compare x y) (> (length x) (length y)))))

;; Apply filter function fn to list lst
(defun filter (fn lst)
  (let ((acc nil))
    (dolist (x lst)
      (let ((val (funcall fn x)))
        (if val (push val acc))))
    (nreverse acc)))

;; Groups List into Sublists of Length n, remainder stored in last sublist
(defun group (source n)
  (if (zerop n) (error "Zero length"))
  (labels ((rec (source acc)
                (let ((rest (nthcdr n source)))
                  (if (consp rest)
                    (rec rest (cons (subseq source 0 n) acc))
                    (nreverse (cons source acc))))))
    (if source (rec source nil) nil)))

; Doubly Recursive List Utilities

;; Flatten List lst with Nested Lists
(defun flatten (x)
  (labels ((rec (x acc)
                (cond ((null x) acc)
                      ((atom x) (cons x acc))
                      (t (rec (car x) (rec (cdr x) acc))))))
    (rec x nil)))

;; Prune List with Nested Lists using the function test
(defun prune (test tree)
  (labels ((rec (tree acc)
                (cond ((null tree) (nreverse acc))
                      ((consp (car tree))
                       (rec (cdr tree)
                            (cons (rec (car tree) nil) acc)))
                      (t (rec (cdr tree)
                              (if (funcall test (car tree))
                                acc
                                (cons (car tree) acc)))))))
    (rec tree nil)))

