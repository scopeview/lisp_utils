(in-package :utils)

(defmacro empty (list)
  `(equal 0 (length ,list)))

(defun notnull (arg)
  (not (null arg)))

(defun length0 (seq)
  (equal 0 (length seq)))

(defun length1 (seq)
  (equal 1 (length seq)))

(defun length2 (seq)
  (equal 2 (length seq)))

(defun notzerop (seq)
  (not (zerop seq)))

(defun index-of (seq obj)
  (let ((index 0))
    (loop for node in seq
       while (if (equal obj node)
		 (return)
		 (incf index))
       finally (setq index nil))
    index))
