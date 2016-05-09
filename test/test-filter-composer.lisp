(in-package :utils-test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; many/many*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::filter-composer--many
    (:tags '(utils-test::tag-filter-composer))
  (let* ((matcher (make-matcher :single-char-test #'isspace))
	 (filter (make-filter matcher))
	 (composed-filter (many filter))
	 (input-1 "h")
	 (input-2 " h")
	 (input-3 "  h")
	 (input-4 "h  "))
    (with-input-from-string (s input-1)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'not-filtered nil) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-2)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list " ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-3)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "  ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-4)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'not-filtered nil) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))))


(lisp-unit2:define-test utils-test::filter-composer--many*
    (:tags '(utils-test::tag-filter-composer))
  (let* ((matcher (make-matcher :single-char-test #'isspace))
	 (filter (make-filter matcher))
	 (composed-filter (many* filter))
	 (input-1 "h")
	 (input-2 " h")
	 (input-3 "  h")
	 (input-4 "h  "))
    (with-input-from-string (s input-1)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered nil) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-2)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list " ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-3)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "  ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-4)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered nil) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; any/any*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::filter-composer--any
    (:tags '(utils-test::tag-filter-composer))
  (let* ((matcher-1 (make-matcher :for-each-single-char-test #'isspace))
	 (matcher-2 (make-matcher :char-pattern #\h))
	 (filter-1 (make-filter matcher-1 :furthest t))
	 (filter-2 (make-filter matcher-2))
	 (composed-filter (any filter-1 filter-2))
	 (input-1 "ha")
	 (input-2 " ha")
	 (input-3 "  ha")
	 (input-4 "ha  ")
	 (input-5 "ah  "))
    (with-input-from-string (s input-1)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "h")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-2)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list " ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-3)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "  ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-4)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "h")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-5)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'not-filtered nil) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))))

(lisp-unit2:define-test utils-test::filter-composer--any*
    (:tags '(utils-test::tag-filter-composer))
  (let* ((matcher-1 (make-matcher :for-each-single-char-test #'isspace))
	 (matcher-2 (make-matcher :char-pattern #\h))
	 (filter-1 (make-filter matcher-1 :furthest t))
	 (filter-2 (make-filter matcher-2))
	 (composed-filter (any* filter-1 filter-2))
	 (input-1 "ha")
	 (input-2 " ha")
	 (input-3 "  ha")
	 (input-4 "ha  ")
	 (input-5 "ah  "))
    (with-input-from-string (s input-1)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "h")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-2)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list " ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-3)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "  ")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))

    (with-input-from-string (s input-4)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "h")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-5)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered nil) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; seq
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::filter-composer--seq
    (:tags '(utils-test::tag-filter-composer))
  (let* ((matcher-1 (make-matcher :for-each-single-char-test #'isspace))
	 (matcher-2 (make-matcher :char-pattern #\h))
	 (matcher-3 (make-matcher :char-pattern #\i))
	 (filter-1 (make-filter matcher-1 :furthest t))
	 (filter-2 (make-filter matcher-2))
	 (filter-3 (make-filter matcher-3))
	 (composed-filter (seq (many* filter-1) filter-2 filter-3))
	 (input-1 "hia")
	 (input-2 " hia")
	 (input-3 "  hia")
	 (input-4 "hia  ")
	 (input-5 "ahi  "))
    (with-input-from-string (s input-1)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "hi")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-2)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list " hi")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-3)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "  hi")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-4)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "hi")) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))

    (with-input-from-string (s input-5)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'not-filtered nil) (funcall composed-filter streamer))
	(lisp-unit2:assert-equal #\a (read-char s nil nil))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; many-any-char
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::filter-composer--many-any
    (:tags '(utils-test::tag-filter-composer))
  (let* ((matcher-1 (make-matcher :char-pattern #\space))
	 (filter-1 (make-filter matcher-1))
	 (filter-2 (make-filter matcher-1))
	 (composed-any-filter (any filter-1 filter-2))
	 (composed-many-any-filter (many composed-any-filter))
	 (input-1 "  ha"))
    (with-input-from-string (s input-1)
      (let ((streamer (make-instance 'cstreamer :source s)))
	(lisp-unit2:assert-equal (list 'filtered (string-to-list "  ")) (funcall composed-many-any-filter streamer))
	(lisp-unit2:assert-equal #\h (read-char s nil nil))))))
