(in-package :utils)

(defmacro defalias (name args realname)
  `(progn
     (defun ,name ,args
       ,(if (eql '&rest (first args))
            `(apply #',realname ,(second args))
            `(,realname ,@args)))
     (define-compiler-macro ,name (&rest args)
       (list* ',realname args))))
;; (defalias path:dirname (pathname) cl-fad:pathname-directory-pathname)
