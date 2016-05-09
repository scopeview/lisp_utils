(in-package :utils)

(defun parse-integer-2-10-16 (string)
  (let ((first-char (subseq string 0 1))
	(second-char (subseq string 1 2)))
    (cond
      ((equal "B" (string-upcase first-char))
       (cl:parse-integer (subseq string 1) :radix 2))
      ((and (equal "0" first-char)
	    (equal "X" (string-upcase second-char)))
       (cl:parse-integer (subseq string 2) :radix 16))
      (t (cl:parse-integer string)))))

;; (parse-integer-2-10-16 "123")
;; (parse-integer-2-10-16 "0x123")
;; (parse-integer-2-10-16 "B111")
