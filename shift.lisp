(in-package :utils)

(defun shift--inner-shift (list)
  (concatenate 'list (cdr list) (list (car list))))

(defun shift--drop-shift (list new-element)
  (concatenate 'list (cdr list) (list new-element)))

(defmacro shift (list &optional element)
  `(if ,element
       (setq ,list (shift--drop-shift ,list ,element))
       (setq ,list (shift--inner-shift ,list))))
