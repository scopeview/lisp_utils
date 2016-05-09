(in-package :utils)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; streamer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defgeneric read-element (streamer))
(defgeneric read-tail-element (streamer))
(defgeneric read-element-all (streamer))
(defgeneric unread-element (streamer element))
(defgeneric unread-element-seq (streamer element-sequence))
(defgeneric add-tail-element (streamer element))
(defgeneric delete-tail-element (streamer))
(defgeneric streamer-length (streamer))
(defgeneric peek-element (streamer))
(defgeneric peek-element-all (streamer))
