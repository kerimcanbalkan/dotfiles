;;; early-init.el --- Early Init -*- lexical-binding: t; -*-

;; Author: Kerimcan Balkan

;;; Commentary:
;; My GNU Emacs config it mostly copied from another people configurations.

;;; Code:

;; Make startup faster by reducing the frequency of garbage collection. This will be set back when startup finishes.
;; We also increase Read Process Output Max so Emacs can read more data.

;; Set garbage collector (from doom emacs)
;; About 0.02 faster
(setq gc-cons-threshold (* 1024 1024 128)  ;; 128mb
      gc-cons-percentage 1.0) ;; Disable the dynamic percentage trigger to ensure GC frequency is fixed.

;; Runtime performance
;; Dial the GC threshold back down so that garbage collection happens more frequently but in less time.
;; Make gc pauses faster by decreasing the threshold.
;; About 0.02 faster
(add-hook 'emacs-startup-hook (lambda ()
                                (setq gc-cons-threshold (* 1024 1024 2) ;; 2mb
                                      gc-cons-percentage 0.2)))

;; Increase the amount of data which Emacs reads from the process
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Unset file-name-handler-alist
;; About 0.07 faster
(defvar last-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'after-init-hook
          (lambda ()
            (setq file-name-handler-alist last-file-name-handler-alist)))

;; Disable UI elements before UI initialization.
;; For faster startup times. It gives 0.05 sec.
(setq menu-bar-mode nil)         ;; Disable the menu bar
(setq tool-bar-mode nil)         ;; Disable the tool bar
(push '(vertical-scroll-bars) default-frame-alist) ;; Disable the scroll bar
(setq-default line-spacing 0.12)

;; Better Window Management handling
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      frame-title-format
      '(:eval
        (let ((project (project-current)))
          (if project
              (concat "Emacs - [p] " (project-name project))
              (concat "Emacs - " (buffer-name))))))

(when (eq system-type 'darwin)
  (setq ns-use-proxy-icon nil))

(setq inhibit-compacting-font-caches t)

;; Disables unused UI Elements
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))
(if (fboundp 'fringe-mode) (fringe-mode -1))


;; Avoid raising the *Messages* buffer if anything is still without
;; lexical bindings
(setq warning-minimum-level :error)
(setq warning-suppress-types '((lexical-binding)))

(setq package-enable-at-startup t)
