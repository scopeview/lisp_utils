(asdf:defsystem :utils-test
  :version "0.0.1"
  :serial t
  :components ((:file "package")
	       (:file "test-basic")
	       (:file "test-stream")
	       (:file "test-streamer")
	       (:file "test-match")
	       (:file "test-matcher")
	       (:file "test-matcher-predefined")
	       (:file "test-filterate")
	       (:file "test-filterate-furthest")
	       (:file "test-filter")
	       (:file "test-filter-composer")
	       (:file "test-shift")
	       (:file "test-unique-id")
	       )
  :depends-on ("utils")
  )
