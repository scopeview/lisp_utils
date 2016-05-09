(in-package :utils-test)

(lisp-unit2:define-test utils-test::basic--empty
    (:tags '(utils-test::tag-basic))
  (lisp-unit2:assert-equal t (empty '()))
  (lisp-unit2:assert-equal nil (empty '(1))))

(lisp-unit2:define-test utils-test::basic--notnull
    (:tags '(utils-test::tag-basic))
  (let ((list-1 '())
	(list-2 '(nil))
	(list-3 '(1))
	(a-1 nil)
	(a-2 t)
	(a-3 1))
    (lisp-unit2:assert-equal nil (notnull list-1))
    (lisp-unit2:assert-equal t (notnull list-2))
    (lisp-unit2:assert-equal t (notnull list-3))
    (lisp-unit2:assert-equal nil (notnull a-1))
    (lisp-unit2:assert-equal t (notnull a-2))
    (lisp-unit2:assert-equal t (notnull a-3))))

(lisp-unit2:define-test utils-test::basic--length1
    (:tags '(utils-test::tag-basic))
  (let ((list-1 '())
	(list-2 '(1))
	(list-3 '(1 2)))
    (lisp-unit2:assert-equal nil (length1 list-1))
    (lisp-unit2:assert-equal t (length1 list-2))
    (lisp-unit2:assert-equal nil (length1 list-3))))

(lisp-unit2:define-test utils-test::basic--index-of
    (:tags '(utils-test::tag-basic))
  (let ((list '(1 2 3)))
    (lisp-unit2:assert-equal 0 (index-of list 1))
    (lisp-unit2:assert-equal 1 (index-of list 2))
    (lisp-unit2:assert-equal 2 (index-of list 3))
    (lisp-unit2:assert-equal nil (index-of list 4))))
