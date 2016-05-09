(in-package :utils)

(defun make-filter (match-test &key furthest)
  (declare (type function match-test))
  (if furthest
      #'(lambda (streamer)
	  (filterate-furthest streamer match-test))
      #'(lambda (streamer)
	  (filterate streamer match-test))))

(defmacro define-filter (name match-test &key furthest)
  `(progn
     (let ((match-test-e ,match-test))
       (declare (type function match-test-e))
       (if ,furthest
	   (defun ,name (streamer)
	     (filterate-furthest streamer match-test-e))
	   (defun ,name (streamer)
	     (filterate streamer match-test-e))))))
