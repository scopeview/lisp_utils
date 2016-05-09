(in-package :utils)

(defun filterate-furthest (streamer match-test)
  "filterate streamer by match-test until the furthest 'full-match, return a cons of status and a list of element. status is
'filtered or
'not-filtered"
  (declare (type function match-test))
  (let ((stack)
	(status-list '(not-match not-match)))
    (labels ((match-more ()
	       (let ((element))
		 (setq element (read-element streamer))
		 (if element
		     (progn
		       (push element stack)
		       (funcall match-test (reverse stack)))
		     'eof)))
	     (unread-stack ()
	       (dolist (element stack)
		 (unread-element streamer element))))
      (loop
	 with status
	 do (progn
	      (setq status (match-more))
	      (shift status-list status))
	 when (or (equal 'not-match status)
		  (equal 'eof status))
	 do (return))
      (cond
	((equal status-list
		'(full-match over-match)) (progn
					    (unread-element streamer (car stack))
					    (list 'filtered (reverse (cdr stack)))))
	((equal status-list
		'(full-match not-match)) (progn
					   (unread-element streamer (car stack))
					   (list 'filtered (reverse (cdr stack)))))
	((equal status-list
		'(full-match eof)) (progn
				     (list 'filtered (reverse stack))))
	((equal status-list
		'(not-match not-match)) (progn
					  (unread-stack)
					  (list 'not-filtered nil)))
	((equal status-list
		'(not-match eof)) (progn
				    (unread-stack)
				    (list 'not-filtered nil)))
	((equal status-list
		'(partial-match eof)) (progn
					(unread-stack)
					(list 'not-filtered nil)))
	(t (error (format nil "unhandled cond ~A" status-list)))))))
