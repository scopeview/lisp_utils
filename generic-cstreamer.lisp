(in-package :utils)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; character streamer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defclass cstreamer ()
  ((source :initarg :source :initform nil)))

(defmethod read-element ((s cstreamer))
  (with-slots (source) s
    (read-char source nil nil)))

(defmethod unread-element ((s cstreamer) element)
  (with-slots (source) s
    (unread-char element source)))

(defmethod unread-element-seq ((s cstreamer) seq)
  (with-slots (source) s
    (loop for i from (1- (length seq)) downto 0
	 do (unread-char (elt seq i) source))))
