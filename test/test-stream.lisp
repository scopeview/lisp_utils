(in-package :utils-test)

(lisp-unit2:define-test utils-test::stream--read-if
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hello world")
    (lisp-unit2:assert-eql nil (read-if #\a s))
    (lisp-unit2:assert-eql #\h (read-if #\h s))
    (lisp-unit2:assert-eql #\e (read-char s nil nil)))
  (with-input-from-string (s "")
    (lisp-unit2:assert-eql nil (read-if #\a s))))


(lisp-unit2:define-test utils-test::stream--read-if-not
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hello world")
    (lisp-unit2:assert-eql #\h (read-if-not #\a s))
    (lisp-unit2:assert-eql nil (read-if-not #\e s))
    (lisp-unit2:assert-eql #\e (read-char s nil nil)))
  (with-input-from-string (s "")
    (lisp-unit2:assert-eql nil (read-if-not #\a s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::stream--read-until
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hello world")
    (lisp-unit2:assert-eql nil (read-until #\h s))
    (lisp-unit2:assert-eql #\h (read-char s nil nil)))
  (with-input-from-string (s "hello world")
    (lisp-unit2:assert-equal '(#\h #\e #\l #\l #\o #\space) (read-until #\w s))
    (lisp-unit2:assert-eql #\w (read-char s nil nil)))
  (with-input-from-string (s "")
    (lisp-unit2:assert-eql nil (read-until #\a s))))


(lisp-unit2:define-test utils-test::stream--read-until-not
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hello world")
    (lisp-unit2:assert-eql nil (read-until-not #\a s))
    (lisp-unit2:assert-eql #\h (read-char s nil nil)))
  (with-input-from-string (s "hhello world")
    (lisp-unit2:assert-equal '(#\h #\h) (read-until-not #\h s))
    (lisp-unit2:assert-eql #\e (read-char s nil nil)))
  (with-input-from-string (s "")
    (lisp-unit2:assert-eql nil (read-until-not #\a s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::stream--read-char-n
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hello world")
    (lisp-unit2:assert-equal nil (read-char-n s 0))
    (lisp-unit2:assert-equal '(#\h) (read-char-n s 1))
    (lisp-unit2:assert-equal '(#\e #\l) (read-char-n s 2))
    (lisp-unit2:assert-equal #\l (read-char s nil nil)))
  (with-input-from-string (s "hello world")
    (lisp-unit2:assert-equal '(#\h #\e #\l #\l #\o) (read-char-n s 5)))
  (with-input-from-string (s "hi")
    (lisp-unit2:assert-equal '(#\h #\i) (read-char-n s 5))
    (lisp-unit2:assert-equal nil (read-char s nil nil)))
  (with-input-from-string (s "")
    (lisp-unit2:assert-equal nil (read-char-n s 1))))

(lisp-unit2:define-test utils-test::stream--read-stream
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hi ")
    (lisp-unit2:assert-equal '(#\h #\i #\space) (read-stream s))
    (lisp-unit2:assert-equal nil (read-char s nil nil)))
  (with-input-from-string (s "")
    (lisp-unit2:assert-equal nil (read-stream s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::stream--unread-list
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hi")
    (let ((stack))
      (push (read-char s nil nil) stack)
      (push (read-char s nil nil) stack)
      (lisp-unit2:assert-equal nil (unread-list (reverse stack) s))
      (lisp-unit2:assert-equal #\h (read-char s nil nil))
      (lisp-unit2:assert-equal #\i (read-char s nil nil))
      (lisp-unit2:assert-equal nil(read-char s nil nil)))))

(lisp-unit2:define-test utils-test::stream--unread-sequence
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "hi")
    (let ((stack))
      (push (read-char s nil nil) stack)
      (push (read-char s nil nil) stack)
      (lisp-unit2:assert-equal nil (unread-sequence (coerce (reverse stack) 'vector) s))
      (lisp-unit2:assert-equal #\h (read-char s nil nil))
      (lisp-unit2:assert-equal #\i (read-char s nil nil))
      (lisp-unit2:assert-equal nil(read-char s nil nil)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(lisp-unit2:define-test utils-test::stream--read-line-n
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "1
22
333")
    (let ((lines (read-line-n s 3)))
      (lisp-unit2:assert-equal "1" (nth 0 lines))
      (lisp-unit2:assert-equal "22" (nth 1 lines))
      (lisp-unit2:assert-equal "333" (nth 2 lines))))
  (with-input-from-string (s "1
22
333")
    (let ((lines (read-line-n s 4)))
      (lisp-unit2:assert-equal 3 (length lines))
      (lisp-unit2:assert-equal "1" (nth 0 lines))
      (lisp-unit2:assert-equal "22" (nth 1 lines))
      (lisp-unit2:assert-equal "333" (nth 2 lines)))))

(lisp-unit2:define-test utils-test::stream--dolines
    (:tags '(utils-test::tag-stream))
  (with-input-from-string (s "1
22
333")
    (let ((lines))
      (dolines (line s)
	(push line lines)
	)
      (setq lines (reverse lines))
      (lisp-unit2:assert-equal 3 (length lines))
      (lisp-unit2:assert-equal "1" (nth 0 lines))
      (lisp-unit2:assert-equal "22" (nth 1 lines))
      (lisp-unit2:assert-equal "333" (nth 2 lines)))))
