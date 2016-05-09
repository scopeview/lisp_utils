(in-package :utils)

(defmacro with-once ((&rest symbols) &body body)
  (let* ((gensym-list (loop for i below (length symbols)
			 collect (gensym))))
    `(progn
       ,@(loop for i below (length symbols)
	    collect `(setq ,(elt `,gensym-list i) ,(elt `,symbols i)))
       (let (,@ (loop for i below (length symbols)
		   collect `(,(elt `,symbols i) (gensym))))
	 ,@ (loop for i below (length symbols)
	       collect `(setq ,(elt `,symbols i) ,(elt `,gensym-list i)))
	    ,@body))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
(let ((a 1)
      (b 2)
      (c 3))
  (m-1 '(with-once (a b c)
	 (list a b c))))
(let ((a 1)
      (b 2)
      (c 3))
  (with-once (a b c)
    (list a b c)))

(let ((count-1 0)
      (count-2 0))
  (macrolet ((pair-bind ((first second) value &body body)
		 `(let ((,first (gensym))
			(,second (gensym)))
		    (setq ,first (car ,value))
		    (setq ,second (cdr ,value))
		    ,@body))
	     (pair-bind-with-once ((first second) value &body body)
	       `(with-once (,value)
		  (let ((,first (gensym))
			(,second (gensym)))
		    (setq ,first (car ,value))
		    (setq ,second (cdr ,value))
		    ,@body))))
    (symbol-macrolet ((next-pair-1 (cons 'a (incf count-1)))
		      (next-pair-2 (cons (incf count-2) 'b)))
      (list (pair-bind (a b) next-pair-1
	      (list a b))
	    (pair-bind-with-once (a b) next-pair-1
	      (list a b))))))

