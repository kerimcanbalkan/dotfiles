;;; init.el --- Kerim's Emacs --- My Emacs configuration -*- lexical-binding: t; -*-
;; Author: Kerimcan Balkan
;; Version: 0.3.3
;; Package-Requires: ((emacs "30.1"))
;; License: GPL-2.0-or-later

;;; Commentary:
;; This is my personal GNU Emacs configuration, I mostly try to use native packages rather than relying on external ones.  An keep it as simple as possible.

;;; Code:
(use-package emacs
  :ensure nil
  :custom                                         ;; Set custom variables to configure Emacs behavior.
  (auto-save-default nil)                         ;; Disable automatic saving of buffers.
  (column-number-mode t)                          ;; Display the column number in the mode line.
  (create-lockfiles nil)                          ;; Prevent the creation of lock files when editing.
  (delete-by-moving-to-trash t)                   ;; Move deleted files to the trash instead of permanently deleting them.
  (delete-selection-mode 1)                       ;; Enable replacing selected text with typed text.
  (global-auto-revert-non-file-buffers t)         ;; Automatically refresh non-file buffers.
  (history-length 25)                             ;; Set the length of the command history.
  (inhibit-splash-screen t)
  (inhibit-startup-screen t)
  (initial-buffer-choice (lambda ()
                           (eshell)
                           (current-buffer)))
  (indent-tabs-mode nil)                          ;; Disable the use of tabs for indentation (use spaces instead).
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
  (treesit-auto-install-grammar t) ; EMACS-31
  (treesit-enabled-modes t)        ; EMACS-31
  (electric-pair-mode t)
  (electric-indent-mode t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (project-vc-extra-root-markers '("Cargo.toml" "package.json" "go.mod")) ; Excelent for mono repos with multiple langs, makes Eglot happy
  (truncate-lines t)                              ;; Enable line truncation to avoid wrapping long lines.
  (use-dialog-box nil)                            ;; Disable dialog boxes in favor of minibuffer prompts.
  (use-short-answers t)                           ;; Use short answers in prompts for quicker responses (y instead of yes)
  (warning-minimum-level :emergency)              ;; Set the minimum level of warnings to display.
  (next-line-add-newlines t)
  (doc-view-continuous t)
  (user-mail-address "kerimcanbalkan@gmail.com"
                     user-full-name "Kerimcan Balkan")
  (read-extended-command-predicate #'command-completion-default-include-p)
  (text-mode-ispell-word-completion nil)
  (redisplay-skip-fontification-on-input t)       ;; Disable fontification while typing
  (cursor-in-non-selected-windows nil)
  (highlight-nonselected-windows nil)
  (save-interprogram-paste-before-kill t)
  (kill-do-not-save-duplicates t)
  :hook                                           ;; Add hooks to enable specific features in certain modes.
  (prog-mode . display-line-numbers-mode)         ;; Enable line numbers in programming modes.
  (doc-view-mode-hook . save-place-mode)
  (doc-view-mode-hook . auto-revert--mode)
  :bind
  (("M-o" . other-window)
   ("C-c t" . eshell)
   ("C-c b k" . kill-current-buffer)
   ("C-c b" . browse-url)
   ("M-TAB" . completion-at-point)
   ("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture))
  :config
  ;; Transparency
  (add-to-list 'default-frame-alist '(alpha-background . 90))
  ;; Disable blinking cursor
  (blink-cursor-mode -1)

  ;; Disable bidirectional text scanning
  ;; This improves performance
  (setq-default bidi-display-reordering 'left-to-right
                bidi-paragraph-direction 'left-to-right)
  (setq bidi-inhibit-bpa t)

  ;; Increase process output buffer for lsp performance
  (setq read-process-output-max (* 4 1024 1024)) ; 4MB

  ;; Handle pinentry
  (setq epg-pinentry-mode 'loopback)

  (defun custom/kill-this-buffer ()
    (interactive) (kill-buffer (current-buffer)))
  (global-set-key (kbd "C-x k") 'custom/kill-this-buffer)

  ;; Save manual customizations to a separate file instead of cluttering init.el
  (setq custom-file (locate-user-emacs-file "custom-vars.el")) ;; Specify the custom file path.
  (load custom-file 'noerror 'nomessage)                       ;; Load the custom file quietly, ignoring errors.

  ;; Makes Emacs vertical divisor the symbol │ instead of |.
  (set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?│))

  ;; Remap dabbrev
  (global-set-key [remap dabbrev-expand] 'hippie-expand)

  :init                        ;; Initialization settings that apply before the package is loaded.
  (add-to-list 'default-frame-alist '(font . "IosevkaTerm Nerd Font Mono-14"))
  (tool-bar-mode -1)           ;; Disable the tool bar for a cleaner interface.
  (menu-bar-mode -1)           ;; Disable the menu bar for a more streamlined look.
  (tooltip-mode -1)
  (global-auto-revert-mode 1)  ;; Enable global auto-revert mode to keep buffers up to date with their corresponding files.
  (recentf-mode 1)             ;; Enable tracking of recently opened files.
  (savehist-mode 1)            ;; Enable saving of command history.
  (save-place-mode 1)          ;; Enable saving the place in files for easier return.
  (winner-mode 1)              ;; Enable winner mode to easily undo window configuration changes.
  (file-name-shadow-mode 1)    ;; Enable shadowing of filenames for clarity.
  (load-theme 'modus-vivendi-deuteranopia)     ;; Load dark theme

  ;; Set the default coding system for files to UTF-8.
  (modify-coding-system-alist 'file "" 'utf-8))

(use-package completion-preview
  :ensure nil
  :demand t
  :bind
  ( :map completion-preview-active-mode-map
    ("M-i" . completion-preview-insert-word)
    ("M-n" . completion-preview-next-candidate)
    ("M-p" . completion-preview-prev-candidate)
    ("M-<return>" . completion-preview-insert)
    ("<tab>" . completion-preview-complete))
  :config
  (setq completion-preview-minimum-symbol-length 2)
  (with-eval-after-load 'org
    (add-to-list 'completion-preview-commands #'org-self-insert-command))
  (global-completion-preview-mode 1))


(use-package minibuffer
  :ensure nil
  :demand t
  :bind
  ( :map completion-in-region-mode-map
    ("M-i" . minibuffer-choose-completion)
    ("M-n" . minibuffer-next-completion)
    ("M-p" . minibuffer-previous-completion))
  :config
  (setq completions-format 'one-column)
  (setq completions-max-height 12)
  (setq completion-auto-help t)
  (setq completion-auto-select nil)
  (setq minibuffer-visible-completions t)
  (setq completion-eager-update t))

(use-package window
  :ensure nil
  :custom
  (display-buffer-alist
   '(("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\|Messages\\|Bookmark List\\|Occur\\|eldoc\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 0)
      (body-function . my-select-window))
     ("\\*\\([Hh]elp\\)\\*"
      (display-buffer-in-side-window)
      (window-width . 75)
      (side . right)
      (slot . 0)
      (body-function . my-select-window))
     ("\\*\\(Ibuffer\\)\\*"
      (display-buffer-in-side-window)
      (window-width . 100)
      (side . right)
      (slot . 1))
     ("\\*Flymake diagnostics\\*" ;; Removed \\|Completions
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 2)
      (body-function . my-select-window))
     ("\\*\\(grep\\|xref\\|find\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 1)))))

(use-package eldoc
  :ensure nil
  :init
  (global-eldoc-mode)
  :custom
  (eldoc-idle-delay 0.2)
  (eldoc-echo-area-use-multiline-p t)
  (eldoc-documentation-strategy #'eldoc-documentation-compose))

(use-package icomplete
  :bind (:map icomplete-minibuffer-map
              ("C-n" . icomplete-forward-completions)
              ("C-p" . icomplete-backward-completions)
              ("RET" . exit-minibuffer))
  :hook
  (after-init . (lambda ()
                  (fido-mode -1)
                  (icomplete-vertical-mode 1)
                  ))
  :config
  (setq icomplete-delay-completions-threshold 0)
  (setq completion-auto-select nil)
  (setq icomplete-compute-delay 0)
  (setq icomplete-show-matches-on-no-input t)
  (setq icomplete-hide-common-prefix nil)
  (setq icomplete-prospects-height 10)
  (setq icomplete-separator " . ")
  (setq icomplete-with-completion-tables t)
  (setq icomplete-max-delay-chars 0)
  (setq icomplete-scroll t))

(use-package project
  :ensure nil
  :bind (("C-x p p" . project-switch-project)
         ("C-x p f" . project-find-file)
         ("C-x p d" . project-dired)
         ("C-x p g" . project-find-regexp)
         ("C-x p b" . project-switch-to-buffer)
         ("C-x p k" . project-kill-buffers)))

(use-package eglot
  :ensure nil
  :custom
  (eglot-autoshutdown t)
  (eglot-events-buffer-size 0) ;; EMACS-31 -- do we still need it?
  (eglot-events-buffer-config '(:size 0 :format full))
  (eglot-prefer-plaintext nil)
  (jsonrpc-event-hook nil)
  (eglot-code-action-indications nil) ;; EMACS-31 -- annoying as hell
  :init
  (fset #'jsonrpc--log-event #'ignore)

  (setq-default eglot-workspace-configuration (quote
                                               (:gopls (:hints (:parameterNames t)))))

  (defun my/eglot-setup ()
    "Setup eglot mode with specific exclusions."
    (unless (memq major-mode '(emacs-lisp-mode lisp-mode))
      (eglot-ensure)))

  (add-hook 'prog-mode-hook #'my/eglot-setup)

  :bind (:map
         eglot-mode-map
         ("C-c l a" . eglot-code-actions)
         ("C-c l o" . eglot-code-action-organize-imports)
         ("C-c l r" . eglot-rename)
         ("C-c l i" . eglot-inlay-hints-mode)
         ("C-c l f" . eglot-format)))

(use-package flymake
  :ensure nil
  :defer t
  :hook (prog-mode . flymake-mode)
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error))
  :custom
  (flymake-indicator-type 'margins)
  (flymake-margin-indicators-string
   `((error "!" compilation-error)
     (warning "?" compilation-warning)
     (note "i" compilation-info))))

(use-package flyspell
  :ensure nil
  :defer t
  :config
  (setq ispell-program-name "aspell")
  (setq ispell-dictionary "en_US")
  (ispell-set-spellchecker-params)
  :hook
  ((text-mode-hook . flyspell-mode)
   (prog-mode-hook . flyspell-prog-mode)))

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-strip-common-suffix t)
  (setq uniquify-after-kill-buffer-p t))

(use-package whitespace
  :ensure nil
  :defer t
  :hook (before-save-hook . whitespace-cleanup))

(use-package org
  :ensure nil
  :defer t
  :custom
  (org-directory "/org")
  (org-agenda-files
   '("~/org/tasks.org"
     "~/org/projects.org"
     "~/org/notes.org"
     "~/org/events.org"))
  (org-default-notes-file "~/org/notes.org")
  (org-capture-templates
   '(("t" "New Task" entry
      (file+headline "~/org/tasks.org" "Inbox")
      "* TODO %?\nCreated: %U\n")

     ("n" "Note" entry
      (file+headline "~/org/notes.org" "Notes")
      "* %?\nCreated: %U\n")

     ("p" "Project Idea" entry
      (file+headline "~/org/projects.org" "Ideas")
      "* %?\nCreated: %U\n")

     ("e" "Event" entry
      (file+headline "~/org/events.org" "Events")
      "* %?\n%^{When}t\n"))))

(use-package newsticker
  :ensure nil
  :custom
  (newsticker-retrieval-interval 0) ;; Only fetches when first opening
  (newsticker-dir (expand-file-name "cache/newsticker/" user-emacs-directory))
  (newsticker-retrieval-method (if (executable-find "wget") 'extern 'intern))
  (newsticker-treeview-listwindow-visible nil)
  (newsticker-wget-arguments
   '("--quiet"
     "--no-hsts"
     "--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
     "--output-document=-"
     "--append-output=/dev/null"))
  :config
  (setq newsticker-url-list
        '(("Protesilaos" "https://protesilaos.com/master.xml" nil 3600)
          ("Joshua Blais" "https://joshblais.com/index.xml" nil 3600)
          ("Richard Stallman" "https://stallman.org/rss/rss.xml" nil 3600)
          ("Jacobin" "https://jacobin.com/feed" nil 3600)
          ("Andrew Tropin" "https://trop.in/feed/blog.xml" nil 3600)
          ("Mihaiol Tenau" "https://mihaiolteanu.me/rss.xml" nil 3600)
          ("Sasha Chua" "https://sachachua.com/blog/feed/index.xml" nil 3600)
          ("Rahul M. Juliato" "https://www.rahuljuliato.com/rss.xml" nil 3600)
          ("Birgun" "https://www.birgun.net/rss/home" nil 3600)
          ("Levizja Bashke" "https://levizjabashke.al/feed.xml" nil 3600)
          ("Emacs Life" "https://planet.emacslife.com/atom.xml" nil 3600)
          ("Celtic Star" "https://thecelticstar.com/feed/" nil 3600)
          ;; Youtube
          ("Sleepy Lifts" "https://www.youtube.com/feeds/videos.xml?playlist_id=UULF4fGQ2r7AcFYAop6qyg_GDw" nil 3600)
          ("Religion For Breakfast" "https://www.youtube.com/feeds/videos.xml?playlist_id=UULFct9aR7HC79Cv2g-9oDOTLw" nil 3600)
          ("Youtux" "https://www.youtube.com/feeds/videos.xml?playlist_id=UULFYlMGSxDy8fCQGXesK64aEg" nil 3600)
          ("Weightlifting House" "https://www.youtube.com/feeds/videos.xml?playlist_id=UULFd5WxLFvKjEbJl5xyUqyHSw" nil 3600)
          ("Emirhan Takva" "https://www.youtube.com/feeds/videos.xml?playlist_id=UULFfEB3XTHTughd6v9c6ctsAQ" nil 3600)
          ("Enis Kirazoglu" "https://www.youtube.com/feeds/videos.xml?playlist_id=UULFXin0u5SrVEBjn5LhOoG97A" nil 3600)
          ("Evrim Agaci" "https://www.youtube.com/feeds/videos.xml?channel_id=UCatnasFAiXUvWwH8NlSdd3A" nil 3600)
          ("Agir Saglam" "https://www.youtube.com/feeds/videos.xml?channel_id=UCXH9dxtCeB3Gn_QnWnBJaTQ" nil 3600)
          ("Omnibus" "https://www.youtube.com/feeds/videos.xml?channel_id=UCmZUVTP8dtWqmsVhqt7tPEQ" nil 3600)
          ("Luke Smith" "https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA" nil 3600)
          ("The PrimeTime" "https://www.youtube.com/feeds/videos.xml?channel_id=UC8ENHE5xdFSwx71u3fDH5Xw" nil 3600)
          ("Joshua Blais Youtube" "https://www.youtube.com/feeds/videos.xml?channel_id=UC1tV5SjRyejRGeHAaMGYSsQ" nil 3600))))

;;; External Packages
;; Email Setup
(require 'mu4e)

(use-package mu4e
  :ensure nil
  :defer 20
  :config
  (setq mail-user-agent 'mu4e)

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/mail/")

  (setq mu4e-drafts-folder "/[Gmail].Drafts")
  (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
  (setq mu4e-refile-folder "/[Gmail].All Mail")
  (setq mu4e-trash-folder  "/[Gmail].Trash")
  (setq mu4e-attachment-dir "~/downloads")
  (setq mm-discouraged-alternatives '("text/html" "text/richtext"))


(setq mu4e-maildir-shortcuts
    '((:maildir "/INBOX"    :key ?i)
      (:maildir "/[Gmail].Sent Mail" :key ?s)
      (:maildir "/[Gmail].Trash"     :key ?t)
      (:maildir "/[Gmail].Drafts"    :key ?d)
      (:maildir "/[Gmail].All Mail"  :key ?a)))
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq smtpmail-smtp-server "smtp.gmail.com"
                        smtpmail-smtp-service 587
                        smtpmail-stream-type 'starttls
                        smtpmail-smtp-user "kerimcanbalkan@gmail.com"
                        smtpmail-auth-credentials "~/.authinfo.gpg"))
(provide 'init)
