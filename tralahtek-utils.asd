(defsystem tralahtek-utils
  :author "Tralah M Brian <musyoki.brian@tralahtek.com>"
  :maintainer "Tralah M Brian <musyoki.brian@tralahtek.com>"
  :homepage "https://github.com/TralahM/lisp_programs"
  :version "0.1"
  :depends-on ()
  :components ((:module "utilities"
                        :serial t
                        :components
                        ((:file "tralahtek-utils"))))
  :description "Getting Started with Lisp and Lisp Packaging"
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op tralahtek-utils-test))))
