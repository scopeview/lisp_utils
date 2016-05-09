(in-package :utils)

;;; TODO
;;; use intern
(defun symbol-concatenate (list)
  (declare (type list list))
  (let ((string-list (mapcar #'(lambda (node)
				 (string-downcase (symbol-name node)))
			     list)))
    (read-from-string (reduce #'(lambda (first second)
				  (concatenate 'string first "-" second))
			      (mapcar #'identity string-list)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(symbol-concatenate '(IPARAMETER PROMPT STRING))

