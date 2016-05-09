(in-package :cl-user)

(defpackage :utils
  (:use cl)
  (:export :assert-true
	   :assert-false
	   :assert-equal
	   :assert-eq
	   :assert-eql
	   :assert-nequal
	   :assert-neq
	   :assert-neql

	   ;; basic
	   :empty
	   :notnull
	   :length0
	   :length1
	   :length2
	   :index-of

	   ;; class
	   :let-with-slots

	   ;; with-gensyms
	   :with-gensyms

	   ;; with-once
	   :with-once

	   ;; cons-list
	   :cons-list

	   ;; quote
	   :is-quoted
	   :unquote
	   :equote
	   :equote-l

	   ;symbol-concatenate
	   :symbol-concatenate

	   ;; macroexpand
	   :m
	   :m-1

	   ;; macro-function
	   :and-f
	   :or-f

	   ;; function-lambda-list
	   :rrest-lambda-list

	   ;; iterate
	   :iterate
	   :iterate2

	   ;; unique-id
	   :unique-id
	   :last-unique-id
	   :next-unique-id

	   ;; transpose
	   :map-transpose
	   :map-transpose-f
	   :map-transpose-f-m

	   ;; lxml
	   :define-lxml
	   :destructuring-bind-lxml
	   :lxml-member

	   ;;;;;;;;;;;;;;;;
	   ;; file
	   :read-file
	   :write-file
	   :append-file
	   :rename-files
	   :mapfile
	   :with-input-file
	   :with-output-file
	   :with-io-file
	   :merge-pathnames-list

	   ;; dir
	   :mkdir-p

	   ;; string
	   :string-to-list

	   ;; stream
	   :read-if
	   :read-if-not
	   :read-until
	   :read-until-not
	   :read-char-n
	   :read-stream
	   :unread-list
	   :unread-sequence
	   :read-line-n
	   :dolines

	   ;; generic
	   :read-element
	   :read-tail-element
	   :read-element-all
	   :unread-element
	   :unread-element-seq
	   :add-tail-element
	   :delete-tail-element
	   :streamer-length
	   :peek-element
	   :peek-element-all
	   ;; streamer
	   :streamer
	   :cstreamer

	   ;; time
	   :stime
	   :to-stime
	   :now

	   ;; character
	   :isalpha
	   :iscntrl
	   :isdigit
	   :islower
	   :isgraph
	   :isprint
	   :ispunct
	   :isspace
	   :isupper
	   :isxdigit

	   ;; match
	   :match

	   ;; matcher
	   :make-matcher
	   :define-matcher

	   ;; matcher-predefined
	   :matcher-identifier
	   :matcher-number
	   :matcher-string

	   ;; filterate
	   :filterate

	   ;; filterate-furthest
	   :filterate-furthest

	   ;; filter
	   :make-filter
	   :define-filter

	   ;; filter-composer
	   :many
	   :many*
	   :any
	   :any*
	   :seq

	   ;; shift
	   :shift
	   ))
