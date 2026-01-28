(cl:defpackage :wx
  (:use :cl)
  (:export))
(cl:in-package :wx)


(claw.wrapper:defwrapper (:claw-wx
                          (:system :claw-wx/wrapper)
                          (:defines "__WXGTK__" 1)
                          (:headers "wx/setup.h"
                                    "wx/wx.h"
                                    "wx/vidmode.h"
                                    "clawed.h")
                          (:includes :wx-includes :wrapper-includes)
                          (:include-sources "clawed\\.h$"
                                            "wx/(app|init|frame|gdicmn|toplevel)\\.h$")
                          (:include-definitions "^wxString::FromUTF8")
                          (:ignore-definitions "^(?!wx).*")
                          (:exclude-definitions "_wxImplementation_"
                                                "^wxPrivate"
                                                "wxTopLevelWindow::wxCreateObject"
                                                "^wxAppConsoleBase::arg")
                          (:targets ((:and :x86-64 :linux) "x86_64-pc-linux-gnu"))
                          (:persistent t)
                          (:language :c++)
                          (:standard :c++11))
  :in-package :%wx
  :trim-enum-prefix t
  :recognize-bitfields t
  :recognize-strings t
  :with-adapter (:static
                 :path "src/lib/adapter.cxx"))
