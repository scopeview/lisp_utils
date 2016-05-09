(in-package :utils)

(defclass unique-id ()
  ((last-unique-id :initarg :last-unique-id :initform 0 :accessor last-unique-id)))

(defmethod next-unique-id ((id unique-id))
  (with-slots (last-unique-id) id
    (setf last-unique-id (+ 1 last-unique-id))))


(defvar *unique-id-ht* (make-hash-table :test 'equal))
(defun unique-id (&key type)
  (assert type)
  (let ((next-id (gethash type *unique-id-ht*))
	(result-id))
    (if next-id
	(progn
	  (setq result-id next-id)
	  (incf (gethash type *unique-id-ht*)))
	(progn
	  (setq result-id 0)
	  (setf (gethash type *unique-id-ht*) 0)))
    result-id))
