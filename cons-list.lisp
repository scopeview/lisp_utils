(in-package :utils)

(defun cons-list (list)
  "make all nodes of list into a plain single list"
  (labels ((reduce-fun (l r)
		       (if (listp l)
			   (append l (if (listp r)
					 r
				       (list r)))
			 (cons l (if (listp r)
				     r
				   (list r)))))
	   (map-fun (node)
		    (if (listp node)
			(cons-list node)
		      node)))
    (reduce #'reduce-fun (mapcar #'map-fun list))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cons-list '(1))
(cons-list '(1 (a (2) b) 3))
