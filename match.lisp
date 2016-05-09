(in-package :utils)

(setq *match-status-list* '(not-match partial-match full-match over-match))

(defun match--list-pattern (pattern input)
  "match pattern with input, return
'not-match or
'partial-match or
'full-match or
'over-match"
  (declare (type cons pattern)
	   (type cons input))
  (assert (notnull pattern))
  (assert (notnull input))
  (let ((length-pattern (length pattern))
	(length-input (length input)))
    (assert (not (equal 0 length-pattern)))
    (assert (not (equal 0 length-input)))
    (if (reduce #'and-f (mapcar #'equal pattern input))
	(cond
	  ((> length-pattern length-input) 'partial-match)
	  ((= length-pattern length-input) 'full-match)
	  ((< length-pattern length-input) 'over-match))
	'not-match)))

(defun match--string-pattern (string-pattern input)
  (match--list-pattern (coerce string-pattern 'list) input))

(defun match--char-pattern (char-pattern input)
  (declare (type character char-pattern)
	   (type cons input))
  (assert (notnull input))
  (if (equal char-pattern (car input))
      (if (length1 input)
	  'full-match
	  'over-match)
      'not-match))

(defun match--any-char-pattern (any-char-pattern input)
  (declare (type list any-char-pattern)
	   (type cons input))
  ;; (loop for char in any-char-pattern
  ;;    do (assert (equal 'standard-char (type-of char))))
  (assert (notnull input))
  (if (member (car input) any-char-pattern)
      (if (length1 input)
	  'full-match
	  'over-match)
      'not-match))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun match--list-test (list-test input)
  (declare (type function list-test)
	   (type cons input))
  (let ((result (funcall list-test input)))
    (assert (member result *match-status-list*))
    result))

(defun match--single-char-test (single-char-test input)
  (declare (type function single-char-test)
	   (type cons input))
  (let ((length-input (length input))
	(result))
    (assert (notzerop length-input))
    (setq result (funcall single-char-test (car input)))
    (if result
	(if (= 1 length-input)
	    'full-match
	    'over-match)
	'not-match)))

(defun match--for-each-single-char-test (for-each-single-char-test input)
  (declare (type function for-each-single-char-test)
	   (type cons input))
  (if (reduce #'and-f (mapcar for-each-single-char-test input))
      'full-match
      'not-match))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun match (input &key list-pattern string-pattern char-pattern any-char-pattern
		      list-test single-char-test for-each-single-char-test)
  (declare (type list input))
  (when (< 1 (count-if #'notnull (list list-pattern string-pattern char-pattern
				       list-test single-char-test for-each-single-char-test)))
    (error (format nil "only one key is allowed")))
  (cond
    (list-pattern (match--list-pattern list-pattern input))
    (string-pattern (match--string-pattern string-pattern input))
    (char-pattern (match--char-pattern char-pattern input))
    (any-char-pattern (match--any-char-pattern any-char-pattern input))
    (list-test (match--list-test list-test input))
    (single-char-test (match--single-char-test single-char-test input))
    (for-each-single-char-test (match--for-each-single-char-test for-each-single-char-test input))))
