;;;  package --- Summary
;;; early-init.el --- Early Init -*- lexical-binding: t; -*-

;; Author: Kerimcan Balkan

;;; Commentary:
;;; My GNU Emacs config it is mostly copied from other people's configurations.

;;; Code:

(setq package-enable-at-startup t)
(setq gc-cons-threshold (* 100 1024 1024))
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)
(setq-default indent-tabs-mode nil)
(setq pop-up-windows nil)
(tool-bar-mode 0)
(tooltip-mode  0)
(scroll-bar-mode 0)

;;; early-init.el ends here
