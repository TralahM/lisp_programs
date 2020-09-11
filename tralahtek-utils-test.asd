(defsystem tralahtek-utils-test
  :author "Tralah M Brian <musyoki.brian@tralahtek.com>"
  :license "GPLv3"
  :depends-on (:tralahtek-utils
               ;:some-test-framework
               )
  :components ((:module "tests"
                :serial t
                :components
                ((:file "tralahtek-utils")))))
