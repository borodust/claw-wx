(cl:defpackage :wx.example
  (:use :cl)
  (:export #:run
           #:load-wx
           #:close-wx))
(cl:in-package :wx.example)


(cffi:define-foreign-library (wx
                              :search-path (asdf:system-relative-pathname :claw-wx/wrapper "src/lib/build/desktop/"))
  (:linux "libwx.clawed.so"))


(defun load-wx ()
  (cffi:load-foreign-library 'wx))


(defun close-wx ()
  (cffi:close-foreign-library 'wx))


(defun run ()
  (values (run-vec3) (run-vec4)))
