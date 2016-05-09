(in-package :cl-user)

(defpackage :utils-test
  (:use :cl :utils)
  (:import-from utils
		#:not-match
		#:partial-match
		#:full-match
		#:over-match

		#:not-filtered
		#:filtered)
  ;; (:export )
  )
