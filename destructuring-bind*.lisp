(in-package :utils)

(defmacro destructuring-bind* ((&rest var-list) form &body body))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun a-fun ()
;;   (list 'filtered "a"))

;; (let ((status)
;;       (content))
;;   (destructuring-bind* (status content) (a-fun))
;;   (list status content))
