(in-package :utils)

(define-matcher matcher-identifier :list-test #'(lambda (input)
						  (if (and (alpha-char-p (car input))
							   (if (cdr input)
							       (reduce #'and-f (mapcar #'alphanumericp (cdr input)))
							       t))
						      'full-match
						      'not-match)))
(define-matcher matcher-number :for-each-single-char-test #'digit-char-p)

;;; TODO
(define-matcher matcher-string :list-test #'(lambda (input)
					      (let ((quote-count (count-if #'(lambda (char) (equal char #\")) input))
						    (is-first-char-quote (equal #\" (car input)))
						    (is-end-char-quote (equal #\" (car (last input)))))
						(cond
						  ((and is-first-char-quote
							is-end-char-quote
							(equal 2 quote-count)) 'full-match)
						  ((and is-first-char-quote
							(< 2 quote-count)) 'over-match)
						  ((and is-first-char-quote
							(= 1 quote-count)) 'partial-match)
						  (t 'not-match)))))
