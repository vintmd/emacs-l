;;; -*- coding: utf-8 -*-

;;; below is used in windows
;;; solve the no auth to .emace.d/server lock
(defadvice server-ensure-safe-dir (around
                                   my-around-server-ensure-safe-dir
                                   activate)
  "Ignores any errors raised from server-ensure-safe-dir"
  (ignore-errors ad-do-it))

(prefer-coding-system 'utf-8)

;;; git bash as term
(setq binary-process-input t)
(setq w32-quote-process-args ?\")
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name "C:/Program Files/Git/git-bash.exe")
(setq explicit-sh-args '("-login" "-i"))

;;; windows end

;;-------------------------------------------
;;; profile
;;-------------------------------------------
(setq my-emacs-conf-profile nil)

(when my-emacs-conf-profile
  (profiler-start 'cpu))

(setq *is-mac* (eql system-type 'darwin))
;;-------------------------------------------
;;; package.el initialize
;;-------------------------------------------
(package-initialize)

;;-------------------------------------------
;;; gc
;;-------------------------------------------
(setq normal-gc-cons-threshold (* 20 1024 1024))
(setq init-gc-cons-threshold (* 128 1024 1024))

(setq gc-cons-threshold init-gc-cons-threshold)

;;-------------------------------------------
;;; set path
;;-------------------------------------------
;;; set user home
(setq user-home-directory
      (file-name-as-directory (expand-file-name "~")))

;;; startup default directory
(setq default-directory user-home-directory)

;;; add sub directory to load-path
(dolist (name '("core" "site-lisp" "module"))
  (add-to-list 'load-path
               (expand-file-name name user-emacs-directory)))

;;-------------------------------------------
;;; hook start
;;-------------------------------------------
(setq inhibit-message t)
(setq emacs-load-start-time (current-time))
(setq custom-file (expand-file-name ".custom.el" user-emacs-directory))

;;-------------------------------------------
;;; load
;;-------------------------------------------
;;; load core
(require 'core-init)

;;; load each module
(autoload-modules)

;;; custom-file
(when (file-exists-p custom-file)
  (load custom-file))
;;-------------------------------------------
;;; hook end
;;-------------------------------------------
;;; recovery
(setq inhibit-message nil)
(setq gc-cons-threshold normal-gc-cons-threshold)

;;; report(replace builtin function)
(defun display-startup-echo-area-message ()
  (when (require 'time-date nil t)
    (message "Emacs startup time: %f seconds."
             (time-to-seconds (time-since emacs-load-start-time)))))

;;; server start
(require 'server)
(unless (server-running-p)
  (server-start))

(when my-emacs-conf-profile
  (with-selected-window
      (get-buffer-window (profiler-report-cpu))
    (evil-emacs-state)
    (delete-other-windows)))

(provide 'init)
