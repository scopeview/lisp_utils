(in-package :utils)

;;; many/many*
;;; any/any*
;;; seq
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; many/many*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun many-common (filter is-match-empty)
  (declare (type function filter))
  #'(lambda (streamer)
      (let ((buf-stack))
	(loop
	   with r
	   while (progn
		   (setq r (funcall filter streamer))
		   (equal 'filtered (car r)))
	   do (push (second r) buf-stack))
	(if buf-stack
	    (list 'filtered (reduce #'(lambda (l r) (concatenate 'list l r)) (reverse buf-stack)))
	    (if is-match-empty
		(list 'filtered nil)
		(list 'not-filtered nil))))))

(defun many (filter)
  (many-common filter nil))
(defun many* (filter)
  (many-common filter t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; any/any*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun any-common (filters is-match-empty)
  #'(lambda (streamer)
      (let ((result))
	(loop for f in filters
	   with r
	   when (progn
		  (setq r (funcall f streamer))
		  (equal 'filtered (car r)))
	   do (progn (setq result r)
		     (return)))
	(if result
	    result
	    (if is-match-empty
		(list 'filtered nil)
		(list 'not-filtered nil))))))

(defun any (&rest filters)
  (any-common filters nil))
(defun any* (&rest filters)
  (any-common filters t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; seq
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun seq (&rest filters)
  "return a concatenated filter result"
  #'(lambda (streamer)
      (let ((buf-stack)
	    (complete t))
	(loop for f in filters
	   with r
	   do (setq r (funcall f streamer))
	   when (not (equal 'filtered (car r)))
	   do (progn
		(setq complete nil)
		(return))
	   do (push (second r) buf-stack))
	(if complete
	    (list 'filtered (reduce #'(lambda (l r) (concatenate 'list l r)) (reverse buf-stack)))
	    (progn
	      (mapcar #'(lambda (buf) (when buf
					(unread-element-seq streamer buf))) (reverse buf-stack))
	      (list 'not-filtered nil))))))

(defun seq-g (&rest filters)
  "return a filtered list, each one is the result of each filter"
  #'(lambda (streamer)
      (let ((buf-stack)
	    (buf)
	    (complete t))
	(loop for f in filters
	   with r
	   do (setq r (funcall f streamer))
	   when (not (equal 'filtered (car r)))
	   do (progn
		(setq complete nil)
		(return))
	   do (push (second r) buf-stack))
	(if complete
	    (list 'filtered (reverse buf-stack))
	    (progn
	      (mapcar #'(lambda (buf) (when buf
					(unread-element-seq streamer buf))) (reverse buf-stack))
	      (list 'not-filtered nil))))))
