;;; kerim.el --- Kerim's Emacs --- My custom functions -*- lexical-binding: t; -*-
;; Author: Kerimcan Balkan
;; Version: 0.3.3
;; Package-Requires: ((emacs "30.1"))
;; License: GPL-2.0-or-later

;;; Commentary:
;; This file contains my custom functions.

;;; Code:

;; Format with prettier
(defun my/find-local-prettier ()
  "Return path to local prettier or nil."
  (let ((root (or (locate-dominating-file default-directory "node_modules")
                  (locate-dominating-file default-directory "package.json"))))
    (when root
      (let ((prettier (expand-file-name "node_modules/.bin/prettier" root)))
        (when (file-executable-p prettier)
          prettier)))))

(defun my/prettier-format-buffer ()
  "Format current buffer using local prettier."
  (interactive)
  (when-let ((prettier (my/find-local-prettier)))
    (let ((point (point)))
      (call-process-region
       (point-min) (point-max)
       prettier
       t   ; replace buffer
       t   ; output to current buffer
       nil
       "--stdin-filepath" (buffer-file-name))
      (goto-char point))))

(defun my/enable-prettier-on-save ()
  "Enable Javascript formatter prettier on save."
  (when (and (buffer-file-name)
             (my/find-local-prettier))
    (add-hook 'before-save-hook #'my/prettier-format-buffer nil t)))

;; Don't lose layout using C-x 1
(winner-mode +1)

(defun toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key (kbd "C-x 1") #'toggle-delete-other-windows)

(defun my/eval-last-sexp-as-comment ()
  "Evaluate last sexp and insert result as a commented OUTPUT line."
  (interactive)
  (let ((result (eval (preceding-sexp))))
    (end-of-line)
    (newline)
    (insert (format ";; %S" result))))

;; Bind it in lisp-interaction-mode
(with-eval-after-load 'lisp-mode
  (define-key lisp-interaction-mode-map (kbd "C-j") #'my/eval-last-sexp-as-comment))

(defvar my/light-theme 'tango)
(defvar my/dark-theme 'modus-vivendi-tritanopia)

(defun my/toggle-theme ()
  "Toggle between defined dark and light themes."
  (interactive)
  (if (equal (car custom-enabled-themes) my/light-theme)
      (progn
        (disable-theme (car custom-enabled-themes))
        (load-theme my/dark-theme t))
    (progn
      (disable-theme (car custom-enabled-themes))
      (load-theme my/light-theme t))))

(global-set-key (kbd "<f5>") #'my/toggle-theme)
;; Set theme
(load-theme my/light-theme)

;; Play videos with mpv
(defun my/play-with-mpv (url &optional new-window)
  "Start mpv with the given URL."
  (interactive)
  (message "Opening %s with mpv..." url)
  (start-process "mpv" nil "mpv" url))

;; Direct all YouTube links to mpv automatically
(setq browse-url-handlers
      '(("youtube\\.com\\|youtu\\.be" . my/play-with-mpv)
        ("." . browse-url-default-browser)))

;; (provide kerim)
;;; kerim.el ends here
