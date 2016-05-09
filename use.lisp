(require "asdf")
(load "/home/dd/develop/clisp/utils/utils.asd")
(require 'utils)
(use-package 'utils)

;;;
(load "~/develop/clisp/utils/test/utils-test.asd")
(require 'utils-test)
(lisp-unit2:run-tests :package :utils-test
		      :run-contexts #'lisp-unit2:with-failure-debugging-context)
