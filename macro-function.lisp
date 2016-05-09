(in-package :utils)

(defun and-f (x y &rest args)
  (if (null args)
      (and x y)
      (and x y args)))

(defun or-f (x y &rest args)
  (if (null args)
      (or x y)
      (or x y args)))
