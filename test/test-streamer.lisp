(in-package :utils-test)

(lisp-unit2:define-test utils-test::streamer--streamer
    (:tags '(utils-test::tag-streamer))
  (let* ((list '(1 2 3))
	 (s (make-instance 'streamer :source list)))
    (lisp-unit2:assert-equal 1 (read-element s))
    (lisp-unit2:assert-equal 2 (read-element s))
    (lisp-unit2:assert-equal 3 (read-element s))
    (lisp-unit2:assert-equal nil (read-element s))
    (unread-element s 1)
    (lisp-unit2:assert-equal 1 (read-element s))
    (lisp-unit2:assert-equal nil (read-element s))

    ;;
    (unread-element-seq s list)
    (lisp-unit2:assert-equal 1 (read-element s))
    (lisp-unit2:assert-equal 2 (read-element s))
    (lisp-unit2:assert-equal 3 (read-element s))
    (lisp-unit2:assert-equal nil (read-element s))))

(lisp-unit2:define-test utils-test::streamer--cstreamer
    (:tags '(utils-test::tag-streamer))
  (with-input-from-string (s "hi")
    (let ((cs (make-instance 'cstreamer :source s)))
      (lisp-unit2:assert-equal #\h (read-element cs))
      (unread-element cs #\h)
      (lisp-unit2:assert-equal #\h (read-element cs))
      (lisp-unit2:assert-equal #\i (read-element cs))
      (lisp-unit2:assert-equal nil (read-element cs))

      ;;
      (unread-element-seq cs (string-to-list "hi"))
      (lisp-unit2:assert-equal #\h (read-element cs))
      (lisp-unit2:assert-equal #\i (read-element cs)))))



