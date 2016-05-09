(in-package :utils)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Note
;;; - the unread behaviour of streamer and cstreamer is different
;;;   streamer can put different thing back and make the list longer than
;;;   its original status, but cstreamer works like standard-stream
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defclass streamer ()
  ((source :initarg :source :initform nil)))

(set-pprint-dispatch 'streamer
		     #'(lambda (stream structure)
			 (with-slots (source) structure
			   (funcall (formatter "~@<#<~;~W ~W>~:>") stream 'streamer (peek-element-all structure)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmethod read-element ((s streamer))
  (with-slots (source) s
    (let ((first (car source)))
      (setq source (cdr source))
      first)))

(defmethod read-tail-element ((s streamer))
  (with-slots (source) s
    (let ((lastone (car (last source))))
      (setq source (butlast source))
      lastone)))

(defmethod read-element-all ((streamer streamer))
  (let ((element-stack))
    (loop
       with element
       while (setq element (read-element streamer))
       do (push element element-stack))
    (reverse element-stack)))

(defmethod unread-element ((s streamer) element)
  (with-slots (source) s
    (push element source)))

(defmethod unread-element-seq ((s streamer) seq)
  (with-slots (source) s
    (loop for i from (1- (length seq)) downto 0
       do (push (elt seq i) source))))

(defmethod add-tail-element ((s streamer) element)
  (with-slots (source) s
    (setq source (concatenate 'list source (list element)))))

(defmethod delete-tail-element ((s streamer))
  (with-slots (source) s
    (setq source (butlast source))))

(defmethod streamer-length ((s streamer))
  (with-slots (source) s
    (length source)))

(defmethod peek-element ((streamer streamer))
  (with-slots (source) streamer
    (car source)))

(defmethod peek-element-all ((streamer streamer))
  (let ((element-stack)
	(result))
    (loop
       with element
       while (setq element (read-element streamer))
       do (push element element-stack))
    (setq result (reverse element-stack))
    (unread-element-seq streamer result)
    result))
