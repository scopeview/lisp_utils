(in-package :utils)

(defun make-matcher (&rest rest &key list-pattern string-pattern char-pattern any-char-pattern
				  list-test single-char-test for-each-single-char-test)
  (when (< 1 (count-if #'notnull (list list-pattern string-pattern char-pattern any-char-pattern
				       list-test single-char-test for-each-single-char-test)))
    (error (format nil "only one key is allowed")))
  #'(lambda (input)
      (apply #'match (cons input rest))))

(defmacro define-matcher (name &rest rest &key list-pattern string-pattern char-pattern any-char-pattern
					    list-test single-char-test for-each-single-char-test)
  `(progn
     (when (< 1 (count-if #'notnull (list ,list-pattern ,string-pattern ,char-pattern ,any-char-pattern
					  ,list-test ,single-char-test ,for-each-single-char-test)))
       (error (format nil "only one key is allowed")))
     (defun ,name (input)
       (funcall #'match input ,@rest))))
