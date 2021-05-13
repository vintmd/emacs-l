;;-------------------------------------------
;;; package
;;-------------------------------------------
(require-package 'lsp-java)
(require-package 'meghanada)

(add-hook 'java-mode-hook
          (lambda ()
            (require 'lsp-java)
            ;; use meghanada
            ;; (meghanada-mode t)
            ;; (meghanada-code-beautify nil)
            ;; use meghanada code format
            ;; (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)
            (let ((plugindir (expand-file-name "plugins" lsp-java-server-install-dir)))
              (when (file-directory-p plugindir)
                (lsp-deferred)))))

(cond
 ((eq system-type 'windows-nt)
  (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
  (setq meghanada-maven-path "mvn.cmd"))
 (t
  (setq meghanada-java-path "java")
      (setq meghanada-maven-path "mvn")))



;;; local install jdt
;; (setq lsp-java-jdt-download-url "file://")
