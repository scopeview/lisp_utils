(in-package :cl-user)

(require 'lisp-unit2)
(require 'utils-test)

(defun run-utils-test ()
  (load "~/develop/clisp/utils/utils.asd")
  (require 'utils)
  (load "~/develop/clisp/utils/test/utils-test.asd")
  (require 'utils-test)

  (lisp-unit2:run-tests :package :utils-test
  			:run-contexts #'lisp-unit2:with-summary-context)
  ;; (lisp-unit2:run-tests :package :utils-test
  ;; 			:run-contexts #'lisp-unit2:with-failure-debugging-context)
)

(run-utils-test)
