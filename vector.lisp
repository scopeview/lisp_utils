(in-package :utils)

(defmacro vector-equal (v1 v2)
  `(equal (coerce ,v1 'list) (coerce ,v2 'list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((v1 #(1 2 3))
      (v2 #(1 2 3)))
  (assert-nequal v1 v2)
  (assert-true (vector-equal v1 v2)))
