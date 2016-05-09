(in-package :utils)

(defun string-to-list (string)
  (declare (type string string))
  (coerce string 'list))
(let ((string "abc")
      (list '(#\a #\b #\c)))
  (assert-equal list (string-to-list string)))
