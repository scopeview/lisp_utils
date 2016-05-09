(in-package :utils)

(defmacro xnconc (l arg)
  `(if (null ,l)
       (setq ,l ,arg)
       (nconc ,l ,arg)))
