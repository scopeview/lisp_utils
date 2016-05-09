(in-package :utils)

(setq *filterate-status-list* '(filtered not-filtered))

(defun filterate (streamer match-test)
  "filterate streamer by match-test until not 'partial-match, return a cons of status and a list of element. status is
'filtered or
'not-filtered"
  (declare (type function match-test))
  (let ((stack)
	(status))
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
	 while (equal 'partial-match (setq status (match-more))))
      (ecase status
	('not-match (progn
		      (unread-stack)
		      (list 'not-filtered nil)))
	('full-match (list 'filtered (reverse stack)))
	('eof (progn
		(unread-stack)
		(list 'not-filtered nil)))))))
