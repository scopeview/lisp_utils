;;; lstruct (list-structure)
;;; - map between list and struct
;;; - data is stored as list, only when lstruct-with-slots, list will be constructed to
;;;   a defstruct.

(in-package:utils)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; internal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq *lstruct-definitions* (make-hash-table :test 'equal))
;; (setq *lstruct-defstruct-prefix "lstruct-")

(defmacro lstruct-defstruct (name definition)
  "define the corresponding struct of lstruct, all "
  (let* ((mapped-structure (mapstruct #'utils:symbol-concatenate `,definition))
	 (consed-list (utils:cons-list mapped-structure)))
    `(defstruct ,name
       ,@consed-list)))

(defun lstruct-check-value (name lstruct-value)
  "check the format of vlaue match the lstruct definition of name")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; API
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmacro define-lstruct (name definition)
  "add definition to *lstruct-definitions* and define a structure"
  `(progn
     (setf (gethash ',name *lstruct-definitions*) ',definition)
     (lstruct-defstruct ,name ,definition)))

(defun make-lstruct (name values)
  "make a lstruct's defstruct from values"
  (declare (type symbol name))
  (let ((definition (gethash name *lstruct-definition*)))
    (unless definition
      (error (format "lstruct definition ~A not defined" name)))
    (progn
      `(,(read-from-string (concatenate 'string "make-" (symbol-name name)))))))


(defmacro lstruct-member (name obj xml-path &body body)
  (let ((member (symbol-concatenate `,xml-path)))
    `(with-slots (,member) ,obj
       ,@body)))

(defun lstruct-map-places (lstruct-definition)
  )



(defmacro with-lstruct-places (lstruct-definition (&rest path-list) lstruct-value &body body)
  )




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lstruct-defstruct 'iparameter '(iparameter-dummy
			    (iparameter-prompt-string iparameter-prompt-color)
			    (iparameter-value-type iparameter-value-default-value iparameter-value-color)))
(make-iparameter)

;;; 
(setq definition '(iparameter
		   dummy
		   (prompt string color)
		   (value type default-value color)))
(define-lstruct 'iparameter definition)

(let ((iparameter (make-iparameter))
      (slots (mapstruct #'symbol-concatenate (gethash 'iparameter *lstruct-definitions*))))
  (with-slots `',slots iparameter
    (list iparameter-dummy)))

(defun lstruct-test ()
  (let ((iparameter (make-iparameter))
	(slots (mapstruct #'symbol-concatenate '(iparameter
						 dummy
						 (prompt string color)
						 (value type default-value color)))))
    (eval `(with-slots ,slots ,iparameter
	(list iparameter-dummy)))))
(lstruct-test)




(let ((iparameter (make-iparameter)))
  (macroexpand-1 '(lstruct-member 'iparameter iparameter '(iparameter prompt string)
     iparameter-prompt-string))
  ;; (lstruct-member 'iparameter iparameter '(iparameter prompt string)
  ;;   (setf iparameter-prompt-string "new-prompt"))
  ;; (lstruct-member 'iparameter iparameter '(iparameter prompt string))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq lstruct-definition-1 '(iparameter
			     dummy
			     (prompt string color)
			     (value type default-value color)))
(setq lstruct-value-1 '(iparameter
			'command-string
			(prompt "command-string" 0)
			(value "std::string" "find-file" 1)))

(with-lstruct-places lstruct-definition-1 ((iparameter-dummy)
					   (iparameter-prompt-string)) lstruct-value-1
					   (setf iparameter-prompt-string "find-file-1"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :skeleton-iparameter)
(defmacro iparameter-lstruct-member ((&rest path))
  (lstruct-member 'iparameter *current-iparameter* (,@path)))

struct iparameter<<% (iparameter-lstruct-member (dummy)) %>>

template<>
struct iparameter_prompt_name {
std::string get () {return <% (iparameter-lstruct-member (prompt name)) %> }
}


;;;;;;;;;;;;;;;;
(make-lstruct-from-xml 'iparameter "
   iparameter>
      <dummy>command-string</dummy>
      <prompt>
  	<string>command-string</string>
  	<color>0</color>
      </prompt>
      <value>
  	<type>std::string</type>
  	<default-value>find-file</default-value>
  	<color>1</color>
      </value>
  </iparameter>>
")
