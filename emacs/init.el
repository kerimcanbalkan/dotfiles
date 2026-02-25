;;; init.el --- Kerim's Emacs --- My Emacs configuration -*- lexical-binding: t; -*-
;; Author: Kerimcan Balkan
;; Version: 0.3.3
;; Package-Requires: ((emacs "30.1"))
;; License: GPL-2.0-or-later

;;; Commentary:
;; It says this part is necessary I do not get why

;; Load my custom functions
(load (expand-file-name "kerim.el" user-emacs-directory))

;; Hopefully read environment variables
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

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
  (project-vc-extra-root-markers '("Cargo.toml" "package.json" "go.mod")) ; Excelent for mono repos with multiple langs, makes Eglot happy
  (truncate-lines t)                              ;; Enable line truncation to avoid wrapping long lines.
  (use-dialog-box nil)                            ;; Disable dialog boxes in favor of minibuffer prompts.
  (use-short-answers t)                           ;; Use short answers in prompts for quicker responses (y instead of yes)
  (warning-minimum-level :emergency)              ;; Set the minimum level of warnings to display.
  (browse-url-browser-function 'eww-browse-url)
  (next-line-add-newlines t)
  (doc-view-continuous t)
  (user-mail-address "kerimcanbalkan@gmail.com"
                     user-full-name "Kerimcan Balkan")
  (read-extended-command-predicate #'command-completion-default-include-p)
  (text-mode-ispell-word-completion nil)
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
   ("<f5>" . my/toggle-theme)
   ("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c l" . org-capture))
  :config
  ;; Set Font
  ;; (set-face-attribute 'default nil :family "Aporetic Sans Mono"  :height 120)

  ;; Set theme
  ;; (load-theme 'modus-operandi)

  ;; Transparency
  ;;(add-to-list 'default-frame-alist '(alpha-background . 90))

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

(use-package man
  :ensure nil
  :hook (Man-mode . (lambda ()
                      (setq Man-notify-method 'pushy)))
  :config
  (setq display-buffer-alist
        '(("\\*Man.*\\*"
           (display-buffer-reuse-window display-buffer-in-side-window)
           (side . right)
           (window-width . 0.5)
           (slot . 0)))))

(use-package eldoc
  :ensure nil
  :custom
  (eldoc-help-at-pt t)
  (eldoc-echo-area-use-multiline-p nil)
  (eldoc-echo-area-prefer-doc-buffer t)
  (eldoc-documentation-strategy 'eldoc-documentation-compose)
  :init
  (global-eldoc-mode))

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
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-next-error))
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

(use-package which-key
  :ensure nil
  :defer t
  :hook
  (after-init . which-key-mode))

(use-package whitespace
  :ensure nil
  :defer t
  :hook (before-save-hook . whitespace-cleanup))

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
  :bind (:map icomplete-minibuffer-map
              ("C-n" . icomplete-forward-completions)
              ("C-p" . icomplete-backward-completions)
              ("C-v" . icomplete-vertical-toggle)
              ("RET" . icomplete-force-complete-and-exit))
  :hook
  (after-init . (lambda ()
                  (fido-mode -1)
                  (icomplete-vertical-mode 1)
                  ))
  :config
  (setq icomplete-delay-completions-threshold 0)
  (setq icomplete-compute-delay 0)
  (setq icomplete-show-matches-on-no-input t)
  (setq icomplete-hide-common-prefix nil)
  (setq icomplete-prospects-height 10)
  (setq icomplete-separator " . ")
  (setq icomplete-with-completion-tables t)
  (setq icomplete-max-delay-chars 0)
  (setq icomplete-scroll t))

;; Setup lsp
(use-package eglot
  :ensure nil
  :hook ((c-mode c++-mode
                 go-ts-mode go-mode
                 web-mode js-ts-mode
                 tsx-ts-mode
                 lua-mode)
         . eglot-ensure)
  :init
  (with-eval-after-load 'eglot
    (add-to-list
     'eglot-server-programs
     '((tsx-ts-mode js-jsx-mode)
       . ("rass"
          "--"
          "typescript-language-server" "--stdio"
          "--"
          "eslint-lsp" "--stdio"
          "--"
          "tailwindcss-language-server" "--stdio"))))
  :bind (:map
         eglot-mode-map
         ("C-c l a" . eglot-code-actions)
         ("C-c l o" . eglot-code-action-organize-imports)
         ("C-c l r" . eglot-rename)
         ("C-c l i" . eglot-inlay-hints-mode)
         ("C-c l f" . eglot-format-buffer))
  :config
  (add-hook 'before-save-hook 'eglot-format-buffer t t)
  (setq-default eglot-workspace-configuration
                '((:tailwindCSS
                   (:includeLanguages
                    (:typescriptreact "html"
                                      :typescript "html"
                                      :javascript "html"
                                      :javascriptreact "html")))))
  (setq-default eglot-workspace-configuration (quote
                                               (:gopls (:hints (:parameterNames t)))))
  (setq eglot-ignored-server-capabilities '( :documentHighlightProvider))
  (setf (plist-get eglot-events-buffer-config :size) 0)
  (add-to-list 'eglot-server-programs
               '(text-mode . ("harper-ls" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(org-mode  . ("harper-ls" "--stdio")))
  :custom
  (fset #'jsonrpc--log-event #'ignore)
  (eglot-events-buffer-size 0)
  (eglot-sync-connect nil)
  (eglot-connect-timeout nil)
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 3)
  (flymake-no-changes-timeout 5)
  (eldoc-echo-area-use-multiline-p nil)
  (eglot-report-progress nil))

(use-package project
  :ensure nil
  :bind (("C-x p p" . project-switch-project)
         ("C-x p f" . project-find-file)
         ("C-x p d" . project-dired)
         ("C-x p g" . project-find-regexp)
         ("C-x p b" . project-switch-to-buffer)
         ("C-x p k" . project-kill-buffers)))

;; Coding
(use-package go-ts-mode
  :mode "\\.go\\'"
  :ensure nil
  :hook (go-ts-mode . my/go-setup)
  :config
  (defun my/go-setup ()
    "Set Go indentation"
    ;; Use tabs for Go, standard Go tab width
    (setq-local indent-tabs-mode t)
    (setq-local tab-width 8)))


(use-package js-ts-mode
  :ensure nil
  :hook (js-ts-mode . my/enable-prettier-on-save)
  :config
  (add-to-list 'treesit-language-source-alist '(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
  (add-to-list 'treesit-language-source-alist '(jsdoc "https://github.com/tree-sitter/tree-sitter-jsdoc" "master" "src"))
  :mode "\\.js\\'")

(use-package tsx-ts-mode
  :ensure nil
  :hook (tsx-ts-mode . my/enable-prettier-on-save)
  :custom
  (tab-width 4)
  :config
  (add-to-list 'treesit-language-source-alist '(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
  :mode "\\.tsx\\'")

(use-package typescript-ts-mode
  :ensure nil
  :hook (typescript-ts-mode . my/enable-prettier-on-save)
  :custom
  (typescript-ts-mode-indent-offset 4)
  :config
  (add-to-list 'treesit-language-source-alist '(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
  :mode "\\.ts\\'")

(use-package html-ts-mode
  :ensure nil
  :hook (html-ts-mode . my/enable-prettier-on-save)
  :mode "\\.html\\'")

(use-package css-ts-mode
  :ensure nil
  :hook (css-ts-mode . my/enable-prettier-on-save)
  :mode "\\.css\\'")

;; Reading News
(use-package newsticker
  :ensure nil
  :custom
  (newsticker-retrieval-interval 0) ;; Only fetches when first opening (avoids unwanted fetching/ui locking while doing other things later)
  (newsticker-treeview-treewindow-width 40)
  (newsticker-dir (expand-file-name "cache/newsticker/" user-emacs-directory))
  (newsticker-retrieval-method (if (executable-find "wget") 'extern 'intern))
  (newsticker-wget-arguments
   '("--quiet"
     "--no-hsts"
     "--output-document=-"
     "--append-output=/dev/null"))
  :config
  (setq newsticker-url-list
        '(("Null Program" "http://nullprogram.com/feed/" nil 3600)
          ("Protesilaos" "https://protesilaos.com/master.xml" nil 3600)
          ("Evrensel" "https://www.evrensel.net/rss/haber.xml" nil 3600)
          ("Joshua Blais" "https://joshblais.com/index.xml" nil 3600)
          ("Richard Stallman" "https://stallman.org/rss/rss.xml" nil 3600)
          ("Jacobin" "https://jacobin.com/feed" nil 3600)
          ("Rahul M. Juliato" "https://www.rahuljuliato.com/rss.xml" nil 3600)
          ("Emacs Life" "https://planet.emacslife.com/atom.xml" nil 3600))))



;;; External Packages
;; (use-package doric-themes
;;   :ensure t
;;   :demand t
;;   :config
;;   ;; These are the default values.
;;   (setq doric-themes-to-toggle '(doric-earth doric-fire))
;;   (setq doric-themes-to-rotate doric-themes-collection)

;;   (doric-themes-select 'doric-fire)

;;   :bind
;;   (("<f5>" . doric-themes-toggle)
;;    ("C-<f5>" . doric-themes-select)
;;    ("M-<f5>" . doric-themes-rotate)))

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-echo-documentation 0.5)
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match 'insert) ;; Configure handling of exact matches
  :bind
  (:map corfu-map
        ("C-j" . corfu-insert))
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package conf-mode
  :ensure nil
  :mode ("\\.env\\..*\\'" "\\.env\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.env\\'" . conf-mode)))

(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :hook ((nov-mode . visual-line-mode)
         (nov-mode . visual-fill-column-mode))
  :config
  (setq nov-text-width 80
        visual-fill-column-center-text t))

;; (use-package magit
;;   :ensure t
;;   :defer t)

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
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq smtpmail-smtp-server "smtp.gmail.com"
                        smtpmail-smtp-service 587
                        smtpmail-stream-type 'starttls
                        smtpmail-smtp-user "kerimcanbalkan@gmail.com"
                        smtpmail-auth-credentials "~/.authinfo.gpg"))

;; Load elegance look
(load (expand-file-name "elegance/sanity.el" user-emacs-directory))
(load (expand-file-name "elegance/elegance.el" user-emacs-directory))
;;; init.el ends here
