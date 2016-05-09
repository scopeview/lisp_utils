(in-package :utils)

(defun iterate (f list &key before after around (mode 'depth-first))
  "iterate node by :mode (depth first or width first)
quoted node is not treated as list. 
:before :after is called on list unit"
  (declare (type function f)
	   (type list list))
  (labels ((iterate-depth-first (node)
	     (if (and (listp node)
		      (not (is-quoted node)))
		 (iterate f node :before before :after after :around around :mode mode)
		 (funcall f node)))
	   (iterate-width-first (node)))
    (let ((result))
      (when before
	(funcall before list))
      (setq result
	    (ecase mode
	      ('depth-first (mapcar #'iterate-depth-first list))
	      ('width-first (mapcar #'iterate-width-first list))))
      (when after
	(funcall after list))
      result)))

(defun iterate2 (f list1 list2)
  "iterate node by :mode (depth first or width first)
quoted node is not treated as list. 
:before :after is called on list unit"
  (declare (type function f))
  (labels ((is-list-node (node)
	     (and (listp node)
		  (not (is-quoted node))))
	   (iterate-depth-first (nodes)
	     (if (is-list-node (car nodes))
		 (multiple-value-call #'iterate2 f (values-list nodes))
		 (multiple-value-call f (values-list nodes)))))
    (mapcar #'iterate-depth-first (map-transpose list1 list2))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let* ((list1 '(1 (2 (3) 4) 5))
       (list2 '(2 (3 (4) 5) 6))
       (expected-result-1 '(2 (3 (4) 5) 6))
       (expected-result-2 '(3 (5 (7) 9) 11)))
  (assert-equal expected-result-1 (iterate #'1+ list1))
  (assert-equal expected-result-2 (iterate2 #'+ list1 list2)))

(let ((list '(1 (2 (3) 4) 5))
      (expected-list '(1 2 3 4 5))
      (result))
  (labels ((concate-node (node)
	     (if result
		 (nconc result (list node))
		 (setq result (list node)))))
    (iterate #'concate-node list))
  (assert-equal expected-list result))

(let ((list '(1 (2 (3) 4) 5))
      (list-consed '(2 3 4 5 6))
      (level-enter-count 0)
      (level-exit-count 0))
  (labels ((level-enter (list)
	     (incf level-enter-count))
	   (level-exit (list)
	     (incf level-exit-count)))
    (iterate #'1+ list :before #'level-enter :after #'level-exit)
    (list level-enter-count level-exit-count)))

(let ((list '(1 '(2 (3) 4) 5)))
  (let ((count 0))
    (labels ((counter (node)
	       (incf count)))
      (iterate #'counter list))
    (assert-equal 3 count)))

