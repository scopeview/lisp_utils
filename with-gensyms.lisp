(in-package :utils)

(defmacro with-gensyms ((&rest symbols) &body body)
  "Replaces symbols in body with new symbols created by gensym.  body is treated as an implicit progn."
  `(let (,@(loop for symbol in symbols collect `(,symbol (gensym))))
     ,@body))
