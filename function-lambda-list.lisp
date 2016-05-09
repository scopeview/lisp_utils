(in-package :utils)

(defun rrest-lambda-list (named-pair &optional keys)
  (if keys
      (loop for i below (length named-pair)
	    with result
	    do (if (member (elt named-pair i) keys)
		   (incf i)
		 (push (elt named-pair i) result))
	    finally (return (reverse result)))
      (loop for (key value) on named-pair by #'cddr
	    unless (keywordp key)
	    append (list key value))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((list '(:a 1 :b 2 3 4))
      (expected-result '(3 4)))
  (assert-equal expected-result (rrest-lambda-list list))
  (assert-equal expected-result (rrest-lambda-list list '(:a :b))))
