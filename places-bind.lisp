(in-package :utils)

;;; places-bind
;;; different from destructuring-bind, setf in places-bind will change data in place

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun map-place-stack (list)
  (let ((position-index-stack)
	(position-index))
    (labels ((level-enter (list)
	       (when position-index
		 (push position-index position-index-stack))
	       (setq position-index 0))
	     (level-exit (list)
	       (setq position-index (pop position-index-stack))
	       (when position-index
		 (incf position-index)))
	     (iterator-on (node)
	       (let (result)
		 (setq result (append (list position-index) position-index-stack))
		 ;; (setq result `'(,@result))
		 (setq result (coerce result 'vector))
		 (incf position-index)
		 result)))
      (iterate #'iterator-on list :before #'level-enter :after #'level-exit))))

(defmacro map-place (list)
  (with-gensyms (stack-list)
    `(let ((,stack-list (map-place-stack ,list)))
       (labels ((it-on (node)
		  (loop with result = ',list
		     with stack = (reverse (coerce node 'list))
		     while (not (empty stack))
		     do (setq result `(nth ,(pop stack) ,result))
		     finally (return `',result))
		  ))
	 (iterate #'it-on ,stack-list)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((value '(iparameter
	       'command-string
	       (prompt "command-string" 0)
	       (value "std::string" "find-file" 1))))
  (places-bind (nil
		dummy
		(nil prompt-string prompt-color)
		(nil value-type value-default value-color))
	       value
	       (setf prompt-string "command-string-modified"))
  value)

(let ((list))
  (symbol-macrolet ((dummy (car (cdr list)))
		    (prompt-string (car (...)))
		       ...)
    (setf prompt-string "modified")))




(eval `(destructuring-bind ,(mapstruct #'utils:symbol-concatenate lstruct-definition-1)))
(mapstruct #'utils:symbol-concatenate lstruct-definition-1)

(let ((l '(1 (2 (3 a) 4) 5)))
  (map-place l))

;;;;;;;;;;;;;;;;
(defmacro places-bind (lambda-list expression &body body)
  (with-gensyms (mapped-places lambda-list-as-list macrolet-lambda-list-uncomposed macrolet-lambda-list)
    `(let* ((,mapped-places (map-place ,expression))
	    (,lambda-list-as-list (iterate2 #'equote2-l ',lambda-list ,mapped-places))
	    (,macrolet-lambda-list-uncomposed)
	    (,macrolet-lambda-list)
	    (,body2 ',body))
       (labels ((collect-not-null (symbolname-expand-pair)
		  (when symbolname-expand-pair
		    (push symbolname-expand-pair ,macrolet-lambda-list-uncomposed)))
		(compose-symbol-macrolet-declaration (node)
		  (let ((unquoted-list (unquote node)))
		    (list (car unquoted-list) (unquote (cadr unquoted-list))))))
	 (iterate #'collect-not-null ,lambda-list-as-list)
	 (setq ,macrolet-lambda-list (mapcar #'compose-symbol-macrolet-declaration (reverse ,macrolet-lambda-list-uncomposed)))
	 ;; (list ,macrolet-lambda-list ',expression ,@body)
	 (eval `(symbol-macrolet ,,macrolet-lambda-list
			   ,@,body2))
	 ))))

