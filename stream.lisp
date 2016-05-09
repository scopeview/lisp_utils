(in-package :utils)

;; read-if
;; read-if-not
;; read-until
;; read-util-not
;; read-char-n
;; read-stream
;; unread-list
;; unread-sequence
;; read-line-n
;; dolines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun read-if (char stream)
  (declare (type standard-char char)
	   (type stream stream))
  (when (equal char (peek-char t stream nil))
    (read-char stream nil nil)))

(defun read-if-not (char stream)
  (declare (type standard-char char)
	   (type stream stream))
  (when (not (equal char (peek-char t stream nil)))
    (read-char stream nil nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun read-until (char stream)
  (declare (type standard-char char)
	   (type stream stream))
  (let ((stack)
	(c))
    (loop
       while (progn
	       (setq c (read-char stream nil nil))
	       (and c
		    (not (equal char c))))
	 do (push c stack))
    (when c
      (unread-char c stream))
    (reverse stack)))

(defun read-until-not (char stream)
  (declare (type standard-char char)
	   (type stream stream))
  (let ((stack)
	(c))
    (loop
       while (progn
	       (setq c (read-char stream nil nil))
	       (and c
		    (equal char c)))
       do (push c stack))
    (when c
      (unread-char c stream))
    (reverse stack)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun read-char-n (stream n)
  (declare (type stream stream)
	   (type integer n))
  (let ((stack))
    (loop for i below n
       with c
       while (setq c (read-char stream nil nil))
       do (push c stack))
    (reverse stack)))

(defun read-stream (stream)
  (declare (type stream stream))
  (let ((stack))
    (loop
       with c
       while (setq c (read-char stream nil nil))
       do (push c stack))
    (reverse stack)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun unread-list (list stream)
  (declare (type cons list)
	   (type stream stream))
  (loop for c in (reverse list)
       do (unread-char c stream)))

(defun unread-sequence (seq stream)
  (loop for i from (1- (length seq)) downto 0
     do (unread-char (elt seq i) stream)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun read-line-n (stream n)
  (declare (type stream stream)
	   (type integer n))
  (let ((lines))
    (loop for i below n
       with line
       while (setq line (read-line stream nil))
       do (push line lines))
    (reverse lines)))

(defmacro dolines ((string &optional (stream *standard-input*)) &body body)
  `(let ((,string (gensym)))
     (loop
	while (setq ,string (read-line ,stream nil))
	do (progn ,@body))))
