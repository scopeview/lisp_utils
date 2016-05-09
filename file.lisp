(in-package :utils)

(defmacro aif2 (test &optional then else)
  (let ((win (gensym)))
    `(multiple-value-bind (it ,win) ,test
       (if (or it ,win) ,then ,else))))

(defmacro awhile2 (test &body body)
  (let ((flag (gensym)))
    `(let ((,flag t))
       (while ,flag
	 (aif2 ,test
	       (progn ,@body)
	       (setq ,flag nil))))))

(let ((g (gensym)))
  (defun read2 (&optional (str *standard-input*))
    (let ((val (read str nil g)))
      (unless (equal val g) (values val t)))))

(defmacro do-file (filename &body body)
  (let ((str (gensym)))
    `(with-open-file (,str ,filename)
       (awhile2 (read2 ,str)
	 ,@body))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmacro string-read-until (s until-char)
  `(read-from-string ,s t ,until-char))
;; (read-from-string  "a=1" t nil 0 nil )

(defmacro with-input-until (stream until-char string-got)
  (let ((tmp-string (gensym))
	(c (gensym)))
    `(progn
       (setq ,tmp-string "")
       (do ((,c (read-char ,stream nil nil) (read-char ,stream nil nil)))
	   ((or (equal ,until-char ,c)
		(null ,c)))
	 (setq ,tmp-string (concatenate 'string ,tmp-string (string ,c))))
       (setq ,string-got ,tmp-string))))

(defmacro line-key-value (line key value)
  (let ((is (gensym)))
    `(with-input-from-string (,is ,line)
       (with-input-until ,is #\= ,key)
       (with-input-until ,is #\= ,value))))
;; (let (key value)
;;   (line-key-value "a=1" key value)
;;   (list key value))

#+nil
(defmacro mapfile (filename (key value) &body body)
  (let ((s (gensym))
	(line (gensym)))
    `(with-open-file (,s ,filename)
       (setq line "")
       (do ((,line (read-line ,s nil nil) (read-line ,s nil nil)))
	   ((null ,line))
	 (line-key-value ,line ,key ,value)
	 ,@body))))
;; (let ((key)
;;       (value))
;;   (mapfile "/home/dd/develop/clisp/utils/file.txt" (key value)
;;     (print (concatenate 'string key ":" value))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mapfile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmacro mapfile ((stream file-list) &body body)
  (with-gensyms (file)
    `(dolist (,file ,file-list)
       (with-open-file (,stream ,file)
	 ,@body))))

;;; test
;; (mapfile (s '("/tmp/a" "/tmp/b")
;;   (print (read-line s nil nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmacro with-input-file ((stream filespec &rest options) &body body)
  `(with-open-file (,stream ,filespec :direction :input options)
     ,@body))

(defmacro with-output-file ((stream filespec &rest options) &body body)
  `(with-open-file (,stream ,filespec :direction :output options)
     ,@body))

(defmacro with-io-file ((stream filespec &rest options) &body body)
  `(with-open-file (,stream ,filespec :direction :io options)
     ,@body))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; read content from file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun read-file (pathname)
  (with-open-file (s pathname)
    (let* ((length (file-length s))
	   (content (make-array length)))
      (read-sequence content s)
      (coerce content 'string))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; write/append content to file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun write-file (pathname content)
  (with-open-file (s pathname :direction :output :if-exists :rename-and-delete :if-does-not-exist :create)
    (write-string content s)))

(defun append-file (pathname content)
  (with-open-file (s pathname :direction :output :if-exists :append :if-does-not-exist :create)
    (write-string content s)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rename-files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun rename-files (from to)
  (dolist (file (directory from))
    (rename-file file (translate-pathname file from to))))
;;; test
;; (rename-files "/tmp/aaa/*.lisp" "/tmp/bbb/1-*.l")

(defun merge-pathnames-list (target &rest pathnames)
  (dolist (p pathnames)
    (setq target (merge-pathnames p target)))
  target)
;;; test
;; (let ((p (make-pathname :directory '(:absolute "tmp/sub") :name "a" :type "txt"))
;;       (p1 (make-pathname :directory '(:absolute "tmp/a")))
;;       (p2 (make-pathname :type "lisp")))
;;   (merge-pathnames-list p p1 p2))
