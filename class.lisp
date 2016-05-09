(in-package :utils)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Note
;;; - let-with-slots cant' setq to slots of class
(defmacro let-with-slots ((&rest lambda-list) obj &body body)
  (let ((with-slots-lambda-list (gensym)))
    (setq with-slots-lambda-list (mapcar #'second lambda-list))
    `(with-slots ,with-slots-lambda-list ,obj
       (let ,lambda-list
	 ,@body))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;; (defclass a-class ()
;;   ((type :initform 1)))
;; (let ((a (make-instance 'a-class)))
;;   (let-with-slots ((tmp-type type)) a
;;     (assert (equal 1 tmp-type))
;;     (setf tmp-type 2))
;;   (with-slots (type) a
;;     ;; error
;;     type))
