(in-package :utils)

;;; map-transpose
;;; iterate-transpose
;;; TODO
;;; - treate map and iterate as iterate function
;;;	(transpose :iterate #'map :op #'list list1 list2)
;;;;;;;;;;;;;;;;
(defmacro map-transpose (&rest lists)
  `(mapcar #'list ,@lists))

(defun map-transpose-f (lists)
  (multiple-value-call #'mapcar #'list (values-list lists)))

(defun map-transpose-f-m (&rest lists)
  (multiple-value-call #'mapcar #'list (values-list (values-list lists))))

;;;;;;;;;;;;;;;;
;; (defmacro iterate-transpose (&rest lists)
;;   `(iterate #'list ,@lists))

;; (defun iterate-transpose-f (lists)
;;   (multiple-value-call #'iterate #'list (values-list lists)))

;; (defun iterate-transpose-f-m (lists)
;;   (multiple-value-call #'iterate #'list (values-list (values-list lists))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let* ((list1 '(1 2 3))
       (list2 '(a b c))
       (list (list list1 list2))
       (expected-list '((1 a) (2 b) (3 c))))
  (assert-equal expected-list (map-transpose list1 list2))
  (assert-equal expected-list (map-transpose-f list))
  (assert-equal expected-list (map-transpose-f-m list)))
(let* ((list1 '(1 (2 (3) 4) 5))
       (list2 '(2 (3 (4) 5) 6))
       (list (list list1 list2))
       (expected-list '((1 2) ((2 (3) 4) (3 (4) 5)) (5 6))))
  (assert-equal expected-list (map-transpose list1 list2))
  (assert-equal expected-list (map-transpose-f list))
  (assert-equal expected-list (map-transpose-f-m list)))

;; (let* ((list1 '(1 (2 (3) 4) 5))
;;        (list2 '(2 (3 (4) 5) 6))
;;        (expected-list '((1 2) ((2 3) ((3 4)) (4 5)) (5 6)))
;;        (expected-list-quoted '('(1 2) ('(2 3) ('(3 4)) '(4 5)) '(5 6))))
;;   (assert-equal expected-list (iterate-transpose list1 list2)))
