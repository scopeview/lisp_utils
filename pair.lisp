(in-package :utils)

;;; use (destructuring-bind (first . second) value body) instead
;; (defmacro pair-bind ((first second) value &body body)
;;   `(with-once (,value)
;;      (let ((,first (gensym))
;; 	   (,second (gensym)))
;;        (setq ,first (car ,value))
;;        (setq ,second (cdr ,value))
;;        ,@body)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;; (let* ((status 'eof)
;;        (buf '(1 2 3))
;;        (pair (cons status buf)))
;;   (pair-bind (status1 buf1) pair
;;     (list status1 buf1)))


