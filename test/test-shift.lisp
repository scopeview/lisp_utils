(in-package :utils-test)

(lisp-unit2:define-test utils-test::shift--shift-inner-shift
    (:tags '(utils-test::tag-shift))
  (let ((list '(1 2 3))
	(expected-list '(2 3 1)))
    (lisp-unit2:assert-equal expected-list (shift list))
    (lisp-unit2:assert-equal expected-list list)))

(lisp-unit2:define-test utils-test::shift--shift-drop-shift
    (:tags '(utils-test::tag-shift))
  (let ((list '(1 2 3))
	(new-element 'a)
	(expected-list '(2 3 a)))
    (lisp-unit2:assert-equal expected-list (shift list new-element))
    (lisp-unit2:assert-equal expected-list list)))
