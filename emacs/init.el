;;; init.el --- Kerim's Emacs --- My Emacs configuration -*- lexical-binding: t; -*-
;; Author: Kerimcan Balkan
;; Version: 0.3.3
;; Package-Requires: ((emacs "30.1"))
;; License: GPL-2.0-or-later

;;; Commentary:
;; It says this part is necessary I do not get why

;;; Code:

(use-package emacs
  :ensure nil
  :custom                                         ;; Set custom variables to configure Emacs behavior.
  (auto-save-default nil)                         ;; Disable automatic saving of buffers.
  (column-number-mode t)                          ;; Display the column number in the mode line.
  (create-lockfiles nil)                          ;; Prevent the creation of lock files when editing.
  (delete-by-moving-to-trash t)                   ;; Move deleted files to the trash instead of permanently deleting them.
  (delete-selection-mode 1)                       ;; Enable replacing selected text with typed text.
  (display-line-numbers-type 'relative)           ;; Use relative line numbering in programming modes.
  (global-auto-revert-non-file-buffers t)         ;; Automatically refresh non-file buffers.
  (history-length 25)                             ;; Set the length of the command history.
  (indent-tabs-mode nil)                          ;; Disable the use of tabs for indentation (use spaces instead).
  (inhibit-startup-message t)                     ;; Disable the startup message when Emacs launches.
  (initial-scratch-message "")                    ;; Clear the initial message in the *scratch* buffer.
  (ispell-dictionary "en_US")                     ;; Set the default dictionary for spell checking.
  (make-backup-files nil)                         ;; Disable creation of backup files.
  (pixel-scroll-precision-mode t)                 ;; Enable precise pixel scrolling.
  (pixel-scroll-precision-use-momentum nil)       ;; Disable momentum scrolling for pixel precision.
  (ring-bell-function 'ignore)                    ;; Disable the audible bell.
  (split-width-threshold 300)                     ;; Prevent automatic window splitting if the window width exceeds 300 pixels.
  (switch-to-buffer-obey-display-actions t)       ;; Make buffer switching respect display actions.
  (tab-always-indent 'complete)                   ;; Make the TAB key complete text instead of just indenting.
  (text-mode-ispell-word-completion nil)
  (tab-width 4)                                   ;; Set the tab width to 4 spaces.
  (treesit-font-lock-level 4)                     ;; Use advanced font locking for Treesit mode.
  (electric-pair-mode t)
  (electric-indent-mode t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (truncate-lines t)                              ;; Enable line truncation to avoid wrapping long lines.
  (use-dialog-box nil)                            ;; Disable dialog boxes in favor of minibuffer prompts.
  (use-short-answers t)                           ;; Use short answers in prompts for quicker responses (y instead of yes)
  (warning-minimum-level :emergency)              ;; Set the minimum level of warnings to display.
  (browse-url-browser-function 'eww-browse-url)
  :hook                                           ;; Add hooks to enable specific features in certain modes.
  (prog-mode . display-line-numbers-mode)         ;; Enable line numbers in programming modes.
  :bind
  (("M-o" . other-window)
   ("C-c t" . vterm)
   ("C-c b k" . kill-current-buffer)
   ("C-c b" . browse-url)
   ("C-c e n" . flymake-goto-next-error)
   ("C-c e p" . flymake-goto-next-error)
   ("M-TAB" . completion-at-point)
   ("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c l" . org-capture))
  :config
  ;; Set Font
  (set-face-attribute 'default nil :family "Aporetic Sans Mono"  :height 120)

  ;; Set theme
  (load-theme 'wombat)
  
  ;; Transparency
  (add-to-list 'default-frame-alist '(alpha-background . 80))

  ;; Save manual customizations to a separate file instead of cluttering init.el
  (setq custom-file (locate-user-emacs-file "custom-vars.el")) ;; Specify the custom file path.
  (load custom-file 'noerror 'nomessage)                       ;; Load the custom file quietly, ignoring errors.

  ;; Makes Emacs vertical divisor the symbol │ instead of |.
  (set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?│))

  ;; Remap dabbrev
  (global-set-key [remap dabbrev-expand] 'hippie-expand)

  :init                        ;; Initialization settings that apply before the package is loaded.
  (tool-bar-mode -1)           ;; Disable the tool bar for a cleaner interface.
  (menu-bar-mode -1)           ;; Disable the menu bar for a more streamlined look.

  (when scroll-bar-mode
    (scroll-bar-mode -1))      ;; Disable the scroll bar if it is active.

  (global-auto-revert-mode 1)  ;; Enable global auto-revert mode to keep buffers up to date with their corresponding files.
  (recentf-mode 1)             ;; Enable tracking of recently opened files.
  (savehist-mode 1)            ;; Enable saving of command history.
  (save-place-mode 1)          ;; Enable saving the place in files for easier return.
  (winner-mode 1)              ;; Enable winner mode to easily undo window configuration changes.
  (file-name-shadow-mode 1)    ;; Enable shadowing of filenames for clarity.

  ;; Set the default coding system for files to UTF-8.
  (modify-coding-system-alist 'file "" 'utf-8)

  ;; Add a hook to run code after Emacs has fully initialized.
  (add-hook 'after-init-hook
            (lambda ()
              (message "Emacs has fully loaded. This code runs after startup.")

              ;; Insert a welcome message in the *scratch* buffer displaying loading time and activated packages.
              (with-current-buffer (get-buffer-create "*scratch*")
                (insert (format
                         ";;    Welcome to Emacs!
;;
;;    Loading time : %s
"
                         (emacs-init-time)
                         ))))))

(use-package window
  :ensure nil
  :custom
  (display-buffer-alist
   '(
     ("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\|[Hh]elp\\|Messages\\|Bookmark List\\|Ibuffer\\|Occur\\|eldoc.*\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 0))

     ("\\*\\(lsp-help\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 0))

     ;; Configuration for displaying various diagnostic buffers on
     ;; bottom 25%:
     ("\\*\\(Flymake diagnostics\\|xref\\|ivy\\|Swiper\\|Completions\\)"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 1))
     )))

(use-package isearch
  :ensure nil
  :config
  (setq isearch-lazy-count t)                  ;; Enable lazy counting to show current match information.
  (setq lazy-count-prefix-format "(%s/%s) ")   ;; Format for displaying current match count.
  (setq lazy-count-suffix-format nil)          ;; Disable suffix formatting for match count.
  (setq search-whitespace-regexp ".*?")        ;; Allow searching across whitespace.
  :bind (("C-s" . isearch-forward)             ;; Bind C-s to forward isearch.
         ("C-r" . isearch-backward)))          ;; Bind C-r to backward isearch.

(use-package flymake
  :ensure nil
  :defer t
  :hook (prog-mode . flymake-mode)
  :custom
  (flymake-margin-indicators-string
   '((error "!»" compilation-error) (warning "»" compilation-warning)
     (note "»" compilation-info))))

(use-package which-key
  :ensure nil
  :defer t
  :hook
  (after-init . which-key-mode))

(use-package org
  :ensure nil
  :defer t
  :custom
  (org-directory "/Documents/Org")
  (org-agenda-files
   '("~/Documents/Org/tasks.org"
     "~/Documents/Org/projects.org"
     "~/Documents/Org/notes.org"))
  (org-default-notes-file "~/Documents/Org/notes.org")
  (org-capture-templates
   '(("t" "New Task" entry
      (file+headline "~/Documents/Org/tasks.org" "Inbox")
      "* TODO %?\n  Created: %U\n")

     ("n" "Note" entry
      (file+headline "~/Documents/Org/notes.org" "Notes")
      "* %?\n  Created: %U\n")

     ("p" "Project Idea" entry
      (file+headline "~/Documents/Org/projects.org" "Ideas")
      "* %?\n  Created: %U\n")
     )))

(use-package icomplete
  :ensure nil
  :custom
  (icomplete-in-buffer t)
  (icomplete-with-completion-tables t)
  :config
  (icomplete-vertical-mode t))

;; Setup lsp
(use-package eglot
  :ensure nil
  :hook ((c-mode c++-mode
                 go-ts-mode go-mode
                 web-mode js-ts-mode
                 org-mode text-mode
                 tsx-ts-mode
                 lua-mode)
         . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(text-mode . ("harper-ls" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(org-mode  . ("harper-ls" "--stdio")))
  :custom
  (eglot-events-buffer-size 0) ;; No event buffers (LSP server logs)
  (eglot-autoshutdown t);; Shutdown unused servers.
  (eglot-report-progress nil) ;; Disable LSP server logs (Don't show lsp messages at the bottom, java)
  )

(use-package project
  :ensure nil
  :bind (("C-x p p" . project-switch-project)
         ("C-x p f" . project-find-file)
         ("C-x p g" . project-find-regexp)
         ("C-x p b" . project-switch-to-buffer)
         ("C-x p k" . project-kill-buffers))
  :custom
  (project-shell-command 'vterm)
  :config
  (project-list-file "/home/kerim/dotfiles/emacs/projects"))

;; Coding
(use-package go-ts-mode
  :mode "\\.go\\'"
  :ensure nil
  :hook (go-ts-mode . my/go-format-on-save)
  :config
  (defun my/go-format-on-save ()
    (add-hook 'before-save-hook #'gofmt-buffer nil t))

  (defun my/gofmt-buffer ()
    (when (and (executable-find "gofmt")
               (buffer-file-name))
      (call-process-region
       (point-min) (point-max)
       "gofmt"
       t t nil))))

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
  (when (and (buffer-file-name)
             (my/find-local-prettier))
    (add-hook 'before-save-hook #'my/prettier-format-buffer nil t)))

(use-package js-ts-mode
  :ensure nil
  :hook (js-ts-mode . my/enable-prettier-on-save)
  :mode "\\.js\\'")

(use-package tsx-ts-mode
  :ensure nil
  :hook (tsx-ts-mode . my/enable-prettier-on-save)
  :mode "\\.tsx\\'")

(use-package typescript-ts-mode
  :ensure nil
  :hook (typescript-ts-mode . my/enable-prettier-on-save)
  :mode "\\.ts\\'")

(use-package html-ts-mode
  :ensure nil
  :hook (html-ts-mode . my/enable-prettier-on-save)
  :mode "\\.html\\'")

(use-package css-ts-mode
  :ensure nil
  :hook (css-ts-mode . my/enable-prettier-on-save)
  :mode "\\.css\\'")

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match 'insert) ;; Configure handling of exact matches
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

(use-package magit
  :ensure t
  :defer t)

;; Email setup
(use-package mu4e
  :ensure nil
  :defer 20
  :config
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")

  (setq mu4e-drafts-folder "/[Gmail]/Drafts")
  (setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
  (setq mu4e-refile-folder "/[Gmail]/All Mail")
  (setq mu4e-trash-folder  "/[Gmail]/Trash")


(setq mu4e-maildir-shortcuts
    '((:maildir "/Inbox"    :key ?i)
      (:maildir "/[Gmail]/Sent Mail" :key ?s)
      (:maildir "/[Gmail]/Trash"     :key ?t)
      (:maildir "/[Gmail]/Drafts"    :key ?d)
      (:maildir "/[Gmail]/All Mail"  :key ?a)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "kerimcanbalkan@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587))

;; Reading News
(use-package newsticker
  :ensure nil
  :config
  (setq newsticker-url-list
        '(("Null Program" "http://nullprogram.com/feed/" nil 3600)
          ("Protesilaos" "https://protesilaos.com/master.xml" nil 3600)
          ("Evrensel" "https://www.evrensel.net/rss/haber.xml" nil 3600)
          ("Joshua Blais" "https://joshblais.com/index.xml" nil 3600)
          ("Jacobin" "https://jacobin.com/feed" nil 3600)
          ("Emacs Life" "https://planet.emacslife.com/atom.xml" nil 3600))))
;;; init.el ends here
