(cl:defpackage :wx.example
  (:use :cl)
  (:export #:run
           #:load-wx
           #:close-wx))
(cl:in-package :wx.example)


(cffi:define-foreign-library (wx
                              :search-path (asdf:system-relative-pathname :claw-wx/wrapper "src/lib/build/desktop/"))
  (:linux "libwx.clawed.so"))


(defun run-app(app)
  (let ((title "Hello CLAW-WX")
        (name "clawed-main-frame"))
    (cffi:with-foreign-strings ((title-ptr "Hello CLAW-WX")
                                (name-ptr "clawed-main-frame"))
      (iffi:with-intricate-instances ((frame-base %wx:wx-frame-base)
                                      (point %wx:wx-point
                                             :int 100
                                             :int 100)
                                      (size %wx:wx-size
                                            :int 800
                                            :int 600))
        (iffi:with-intricate-allocs ((title-wx %wx:wx-string)
                                     (name-wx %wx:wx-string))
          (%wx:wx-string+from-utf8
           '(:pointer %wx:wx-string) title-wx
           :string title-ptr
           '%wx:size-t (length title))

          (%wx:wx-string+from-utf8
           '(:pointer %wx:wx-string) name-wx
           :string name-ptr
           '%wx:size-t (length name))

          (let ((frame (%wx:new
                        '(:pointer %wx:wx-frame-base) frame-base
                        '(:pointer %wx:wx-window) (cffi:null-pointer)
                        '%wx:wx-window-id -1
                        '(:reference (%wx:wx-string :const)) title-wx
                        '(:reference (%wx:wx-point :const)) point
                        '(:reference (%wx:wx-size :const)) size
                        :long %wx:+wx-default-frame-style+
                        '(:reference (%wx:wx-string :const)) name-wx)))
            (%wx:show-without-activating
             '(:pointer %wx::wx-top-level-window-base) frame)))
        (%wx:on-run
         '(:pointer %wx:wx-app-base) app)))))


(defun run-main ()
  (let ((argc (cffi:foreign-alloc :int)))
    (setf (cffi:mem-ref argc :int) 0)
    (unless (%wx:wx-entry-start
             '(:reference :int) argc
             ':string (cffi:null-pointer))
      (error "Failed to start wxWidgets"))
    (unwind-protect
         (run-app (%wx:wx-get-app))
      (%wx:wx-entry-cleanup)
      (cffi:foreign-free argc))))


(defun run ()
  (cffi:load-foreign-library 'wx)
  (unwind-protect
       (float-features:with-float-traps-masked t
         (run-main))
    (cffi:close-foreign-library 'wx)))
