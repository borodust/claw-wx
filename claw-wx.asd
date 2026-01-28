(asdf:defsystem :claw-wx
  :description "Wrapper over wxWidgets GUI library"
  :version "1.0.0"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :license "MIT"
  :depends-on (:claw-wx-bindings))


(asdf:defsystem :claw-wx/wrapper
  :description "Wrapper over wxWidgets GUI library"
  :version "1.0.0"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :license "MIT"
  :depends-on (:alexandria :cffi :claw :claw-utils)
  :serial t
  :components ((:file "src/claw")
               (:module :wrapper-includes :pathname "src/lib/include/")
               (:module :wx-includes :pathname "src/lib/wx/include/")))


(asdf:defsystem :claw-wx/example
  :description ""
  :version "1.0.0"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :license "MIT"
  :depends-on (:float-features :cffi :claw-wx)
  :serial t
  :pathname "example/"
  :components ((:file "example")))
