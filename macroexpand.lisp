(in-package :utils)

(defmacro m (expr)
  `(macroexpand ,expr))

(defmacro m-1 (expr)
  `(macroexpand-1 ,expr))
