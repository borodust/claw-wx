(cl:defpackage :wx
  (:use :cl)
  (:export))
(cl:in-package :wx)


(claw.wrapper:defwrapper (:claw-wx
                          (:system :claw-wx/wrapper)
                          (:headers "wx/wx.h")
                          (:includes :wx-includes :wrapper-includes)
                          (:include-definitions "^wx\\w+")
                          (:targets ((:and :x86-64 :linux) "x86_64-pc-linux-gnu"))
                          (:persistent t :depends-on (:claw-utils))
                          (:language :c++))
  :in-package :%wx
  :trim-enum-prefix t
  :recognize-bitfields t
  :recognize-strings t
  :with-adapter (:static
                 :path "src/lib/adapter.cxx")
  :override-types ((:string claw-utils:claw-string)
                   (:pointer claw-utils:claw-pointer)))
