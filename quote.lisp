(in-package :utils)

(defun is-quoted (obj)
  (and (listp obj)
       (equal 2 (length obj))
       (equal 'quote (car obj))))

(defun unquote (obj)
  (unless (is-quoted obj)
    (error "not quoted object"))
  (cadr obj))

(defun equote (var)
  "eval then quote, return the quoted value of var"
  `,var)
(defun equote-l (&rest list)
  "eval each node in list, return them as a quoted list"
  `,list)
(defun equote2-l (&rest list)
  "eval each node in list, return them as a quoted list"
  `',list)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((a '('1 '2 '3))
      (result '(t t t)))
  (assert-equal result (mapcar #'is-quoted a)))
(let ((a '('1 '2 '3))
      (result '(1 2 3)))
  (assert-equal '(1 2 3) (unquote ''(1 2 3)))
  (assert-equal result (mapcar #'unquote a)))
(let ((a '(1 2 3))
      (b '(a b c))
      (c 1)
      (result '((1 2 3) (a b c) 1)))
  (assert-equal '(1 2 3) (equote a))
  (assert-equal result (equote-l a b c))
  (assert-equal result (equote-l '(1 2 3) '(a b c) 1)))
