(hall-description
  (name "lzlib")
  (prefix "guile")
  (version "0.2")
  (author "Mathieu Othacehe")
  (copyright (2020))
  (synopsis "")
  (description "")
  (home-page "")
  (license gpl3+)
  (dependencies `())
  (files (libraries
           ((scheme-file "lzlib")
            (directory "lzlib" ((scheme-file "config")))))
         (tests ((directory "tests" ((scheme-file "lzlib")))))
         (programs ())
         (documentation
           ((org-file "README")
            (symlink "README" "README.org")
            (text-file "HACKING")
            (text-file "COPYING")
            (text-file "NEWS")
            (text-file "AUTHORS")
            (text-file "ChangeLog")))
         (infrastructure
           ((scheme-file "guix")
            (scheme-file "hall")
            (directory
              "build-aux"
              ((scheme-file "test-driver")))
            (autoconf-file "configure")
            (automake-file "Makefile")
            (in-file "pre-inst-env")))))
