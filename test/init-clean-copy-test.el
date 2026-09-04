;;; init-clean-copy-test.el --- Checks for init-clean-copy -*- lexical-binding: t -*-

(require 'ert)
(require 'init-clean-copy)

(ert-deftest clean-copy-removes-language-debug-output ()
  (dolist (case '((python-ts-mode "print(value)\n")
                  (js-ts-mode "console.log(value);\n")
                  (go-ts-mode "fmt.Println(value)\n")
                  (csharp-ts-mode "Console.WriteLine(value);\n")
                  (elixir-ts-mode "IO.inspect(value)\n")
                  (erlang-mode "io:format(\"~p\", [Value]),\n")
                  (haskell-mode "print value\n")))
    (let ((kill-ring nil)
          (kill-ring-yank-pointer nil)
          (interprogram-cut-function nil))
      (with-temp-buffer
        (setq major-mode (car case))
        (insert "keep\n" (cadr case) "return\n")
        (copy-region-without-debug-output (point-min) (point-max))
        (should (equal (car kill-ring) "keep\nreturn\n"))))))

(ert-deftest clean-copy-accepts-custom-debug-output-regexp ()
  (let ((clean-copy-debug-output-regexps nil)
        (clean-copy-extra-debug-output-regexps
         '("^[[:blank:]]*TRACE:"))
        (kill-ring nil)
        (kill-ring-yank-pointer nil)
        (interprogram-cut-function nil))
    (with-temp-buffer
      (insert "keep\nTRACE: temporary\nreturn\n")
      (copy-region-without-debug-output (point-min) (point-max))
      (should (equal (car kill-ring) "keep\nreturn\n")))))

;;; init-clean-copy-test.el ends here
