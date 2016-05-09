;;; lxml (list of xml)

(in-package :utils)

(setq *lxml-definitions* (make-hash-table :test #'equal))

(defun maplxml (structure)
  (labels ((is-tag (node)
	     (symbolp node))
	   (is-value-node (list)
	     (and (listp list)
		  (= 1 (length list))
		  (symbolp (car list))))
	   (transform-tag-node (stack node)
	     (assert (is-tag node))
	     (symbol-concatenate `(tag ,node)))
	   (transform-value-node (stack list)
	     (assert (is-value-node list))
	     (let ((new-stack stack)
		   (new-symbol))
	       (push (car list) new-stack)
	       (setq new-symbol (symbol-concatenate `,(reverse new-stack)))
	       `(,(transform-tag-node stack new-symbol) ,new-symbol)))
	   (transform-tag-list (stack list)
	     (let ((new-stack stack)
		   (first (car list)))
	       (push first new-stack)
	       `(,(transform-tag-node stack first) ,(mapcar #'(lambda (node)
								(funcall #'transform new-stack node)) (cadr list)))))
	   (transform (stack list)
	     (cond
	       ((is-value-node list) (transform-value-node stack list))
	       ((is-tag list) (transform-tag-node stack list))
	       (t (if (is-value-node (car list))
		   (mapcar #'(lambda (node)
			       (funcall #'transform stack node)) list)
		   (transform-tag-list stack list))))))
    (transform nil structure)))

(defmacro define-lxml (name definition)
  (let ((destructuring-bind-macro-name (gensym))
	(destructuring-bind-lambda-list (gensym)))
    (setq destructuring-bind-macro-name (symbol-concatenate `(destructuring-bind-lxml ,name)))
    `(progn
      (setq ,destructuring-bind-lambda-list (maplxml ,definition))
      (setf (gethash ',name *lxml-definitions*) ,definition)
      (macrolet ((define-lxml-internal (name-internal lambda-list)
		    `(defmacro ,name-internal (value &body body)
		       `(destructuring-bind ,,lambda-list ,value
			  ,@body))))
	(define-lxml-internal ,destructuring-bind-macro-name ,destructuring-bind-lambda-list)))))

(defmacro destructuring-bind-lxml (name value &body body)
  (let ((destructuring-bind-macro-name (gensym)))
    (setq destructuring-bind-macro-name (symbol-concatenate `(destructuring-bind-lxml ,name)))
    `(,destructuring-bind-macro-name ,value ,@body)))

(defmacro lxml-member (name (&rest path) value)
  (let ((composed-path (gensym)))
    (setq composed-path (symbol-concatenate `,path))
    `(destructuring-bind-lxml ,name ,value
       ,composed-path)))

(defun lxml-destructuring-bind-lambda-list (name)
  (let ((lxml-definition (gethash name *lxml-definitions*)))
    (unless lxml-definition
      (error (format nil "definition of ~A not found" name)))
    (maplxml lxml-definition)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq test-definition '(iparameter
;; 			((dummy)
;; 			 (prompt ((string)
;; 				  (color)))
;; 			 (value ((type)
;; 				 (default-value)
;; 				 (color))))))
;; (define-lxml iparameter test-definition)

;; (let ((lxml-bind-lambda-list '(tag-iparameter
;; 			       ((tag-iparameter-dummy iparameter-dummy)
;; 				(tag-prompt
;; 				 ((tag-iparameter-prompt-string iparameter-prompt-string)
;; 				  (tag-iparameter-prompt-color iparameter-prompt-color)))
;; 				(tag-value
;; 				 ((tag-iparameter-value-type iparameter-value-type)
;; 				  (tag-iparameter-value-default-value iparameter-value-default-value)
;; 				  (tag-iparameter-value-color iparameter-value-color)))))))
;;   (assert-equal lxml-bind-lambda-list (lxml-destructuring-bind-lambda-list 'iparameter)))


;; (let ((value '("iparameter"
;; 	       (("dummy" "command-string")
;; 		("prompt" (("string" "command string") ("color" "0")))
;; 		("value"
;; 		 (("type" "std::string") ("default-value" "find-file") ("color" "1")))))))
;;   (destructuring-bind-lxml iparameter value
;;     (list iparameter-dummy
;; 	  iparameter-prompt-string
;; 	  iparameter-prompt-color
;; 	  iparameter-value-type
;; 	  iparameter-value-default-value
;; 	  iparameter-value-color))
;;   ;; (lxml-member iparameter (iparameter prompt string) value)
;;   ;; (lxml-member iparameter (iparameter value color) value)
;;   )
