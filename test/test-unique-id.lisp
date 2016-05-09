(in-package :utils-test)

(lisp-unit2:define-test utils-test::unique-id--next-unique-id
    (:tags '(utils-test::tag-unique-id))
  (let ((id (make-instance 'unique-id)))
    (lisp-unit2:assert-equal 1 (next-unique-id id))
    (lisp-unit2:assert-equal 2 (next-unique-id id))
    (lisp-unit2:assert-equal 2 (last-unique-id id))
    (with-slots (last-unique-id) id
      (lisp-unit2:assert-equal 2 last-unique-id))))

(lisp-unit2:define-test utils-test::unique-id--next-unique-id-2
    (:tags '(utils-test::tag-unique-id))
  (let ((id (make-instance 'unique-id :last-unique-id 1)))
    (lisp-unit2:assert-equal 2 (next-unique-id id))
    (lisp-unit2:assert-equal 3 (next-unique-id id))
    (lisp-unit2:assert-equal 3 (last-unique-id id))
    (with-slots (last-unique-id) id
      (lisp-unit2:assert-equal 3 last-unique-id))))
