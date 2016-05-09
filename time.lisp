(in-package :utils)

(defstruct stime
  second minute hour date month year day daylight-p zone)

(defun to-stime (time)
  (multiple-value-bind (second minute hour date month year day daylight-p zone) (decode-universal-time time)
      (make-stime :second second
		  :minute minute
		  :hour hour
		  :date date
		  :month month
		  :year year
		  :day day
		  :daylight-p daylight-p
		  :zone zone)))

(defun now ()
  (to-stime (get-universal-time)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;; (let ((time (to-stime (get-universal-time))))
;;   (stime-second time))
