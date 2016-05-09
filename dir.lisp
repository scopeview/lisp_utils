(in-package :utils)

(defun mkdir-p (dir)
  (ensure-directories-exist dir))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (mkdir-p (make-pathname :directory '(:absolute "tmp" "ccc" "ddd")))
