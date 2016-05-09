(in-package :utils)

;;; simple math
;;; - number generator with factor (begin, end, factor)
;;;	- step N factor
;;;	- powerN factor
;;;	- logN factor
;;;	- sin/cos factor
;;; - XY coordinate
;;; - XY coordinate transform

(defclass generator ()
  )


(defclass num1N ()
  ((index :initform 0)))
;; (defmethod initialize-instance :after ((num1N num1N) &rest initargs)
;;   (with-slots (index) num1N
;;     (if )))
(defmethod next ((num1N num1N))
  (with-slots (index) num1N
    (incf index)))


(defclass stepper ()
  ((step-unit :initargs :step-unit :initform 1)))

(defclass changer ()
  ((stepper)
   (direction)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((g (make-instance 'num1N)))
  (next g))
