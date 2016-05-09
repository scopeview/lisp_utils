(in-package :utils)

;;; simple math
;;; - number generator with factor (begin, end, factor)
;;;	- step N factor
;;;	- powerN factor
;;;	- logN factor
;;;	- sin/cos factor
;;; - XY coordinate
;;; - XY coordinate transform

(defclass xy ()
  ((x)
   (y)))

(defclass coordinate-xy ()
  ((x-begin)
   (x-end)
   (y-begin)
   (y-end)
   (x-current)
   (y-current)
   (x-factor)
   (y-factor)))

(defclass coordinate-reference ()
  ((coordinate-xy-reference)
   (x-current)
   (y-current)
   (x-factor)
   (y-factor)))

(defclass coordinate-reference-limit ()
  ((coordinate-xy-reference)
   (x-begin)
   (x-end)
   (y-begin)
   (y-end)
   (x-current)
   (y-current)
   (x-factor)
   (y-factor)))

