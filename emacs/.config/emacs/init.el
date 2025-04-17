;;; Performance tweaks for modern machines
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode 1)
(pixel-scroll-precision-mode 1)
(blink-cursor-mode -1)
(setq visible-bell 1)

;; Emacs defaults change
(setq make-backup-files nil)
(setq auto-save-default nil)
(setopt inhibit-splash-screen t)
(setopt make-backup-files nil)
(setopt create-lockfiles nil)
(set-fringe-mode 0)
(add-to-list 'default-frame-alist '(undecorated . t))
(setq use-short-answers t) ;; y-n instead of yes-no

;; Color theme
(setq modus-themes-bold-constructs t)
(setq modus-themes-italic-constructs t)
(setq modus-themes-mode-line '(borderless))
(setq modus-themes-syntax '(faint alt-syntax green-strings yellow-comments))
(setq modus-themes-headings
      (quote ((1 . (variable-pitch 2.0))
              (2 . (rainbow 1.3))
              (3 . (1.1))
              (t . (monochrome)))))
(setq modus-themes-mixed-fonts t)

(load-theme 'modus-vivendi)

;; Automatically reread from disk if the underlying files changes
(setopt auto-revert-avoid-polling t)

;; Font
(set-face-attribute 'default nil :font "RobotoMono Nerd Font" :height 140)

;; Add unique buffer names in the minibuffer.
(require 'uniquify)

;; Automatically insert closing parens
(electric-pair-mode t)

;; Indenting
(electric-indent-mode t)

;; Visualize matching parens
(show-paren-mode 1)

;; Prefer spaces to tabs
(setq-default indent-tabs-mode nil)

;; Automatically save your place in files
(save-place-mode t)

;; Save history in minibuffer to keep recent commands easily accessible
(savehist-mode t)

;; Keep track of open files
(recentf-mode t)

;; Keep files up-to-date when they change outside Emacs
(global-auto-revert-mode t)

;; Display line numbers only when in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; The `setq' special form is used for setting variables. Remember
;; that you can look up these variables with "C-h v variable-name".
(setq uniquify-buffer-name-style 'forward
      window-resize-pixelwise t
      frame-resize-pixelwise t
      load-prefer-newer t
      backup-by-copying t
      ;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Bring in package utilities so we can install packages from the web.
(require 'package)

;; Add MELPA, an unofficial
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Unless we've already fetched (and cached) the package archives, refresh them.
(unless package-archive-contents
  (package-refresh-contents))

;; Hope this works for fucking env variables.
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;;; Minibuffer completion

;; Vertico: better vertical completion for minibuffer commands
(use-package vertico
  :ensure t
  :init
  ;; You'll want to make sure that e.g. fido-mode isn't enabled
  (vertico-mode))

(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map
              ("<backspace>" . vertico-directory-delete-char)))

;; Marginalia: annotations for minibuffer
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; Company mode
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay 0.2)
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  (company-selection-wrap-around t))


;; Fancy completion-at-point functions; there's too much in the cape package to
(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; Orderless: powerful completion style
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

;; Add extra context to Emacs documentation to help make it easier to understand Emacs.
(use-package helpful
  :ensure t
  :bind (("C-h f" . #'helpful-callable)
         ("C-h v" . #'helpful-variable)
         ("C-h k" . #'helpful-key)
         ("C-c C-d" . #'helpful-at-point)
         ("C-h F" . #'helpful-function)
         ("C-h C" . #'helpful-command)))

;; An extremely feature-rich git client. Activate it with "C-c g".
(use-package magit
  :ensure t
  :defer t
  :bind (("C-c g" . magit-status)))

;; Helps with parenthesis while working with lisp.
(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . enable-paredit-mode)
         (lisp-mode . enable-paredit-mode)
         (ielm-mode . enable-paredit-mode)
         (lisp-interaction-mode . enable-paredit-mode)
         (scheme-mode . enable-paredit-mode)))

;;; Programming stuff
;; Adds LSP support.
(use-package eglot
  :ensure t
  :bind (("s-<mouse-1>" . eglot-find-implementation)
         ("C-c ." . eglot-code-action-quickfix))
  ;; Add your programming modes here to automatically start Eglot,
  :hook ((js-mode . eglot-ensure)
         (go-mode . eglot-ensure)
         (common-lisp-mode . eglot-ensure)
         (js-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (html-mode . eglot-ensure)
         (css-mode . eglot-ensure)
)
  :config
    (add-to-list 'eglot-server-programs
                      '((html-mode css-mode) . ("vscode-html-language-server" "--stdio")))
    (add-to-list 'eglot-server-programs
                 '((js-mode js-ts-mode tsx-ts-mode typescript-ts-mode)
                   . ("typescript-language-server" "--stdio"))))

;; Enable tsx-ts-mode for .tsx and .jsx files
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-ts-mode))

;; Eglot optimization from minimal-emacs
;;; Eglot
(setq eglot-sync-connect 1
      eglot-autoshutdown t)

;; Activate Eglot in cross-referenced non-project files
(setq eglot-extend-to-xref t)

;; Eglot optimization
(setq eglot-events-buffer-size 0)
(setq eglot-report-progress nil)  ; Prevent Eglot minibuffer spam


;; Rainbow-mode for CSS color previews in JSX/TSX
(use-package rainbow-mode
  :ensure t
  :hook ((css-mode tsx-ts-mode js-ts-mode) . rainbow-mode))

;; Emmet-mode for auto-closing HTML/JSX tags
(use-package emmet-mode
  :ensure t
  :hook ((tsx-ts-mode js-ts-mode html-mode) . emmet-mode))


;; Set up indentation for JavaScript/TypeScript
(setq-default indent-tabs-mode nil) ;; Use spaces instead of tabs
(setq-default js-indent-level 2) ;; JavaScript indentation
(setq-default typescript-ts-mode-indent-offset 2) ;; TypeScript indentation
(setq-default tsx-ts-mode-indent-offset 2) ;; TSX indentation


;; Flymake configurations
(use-package flymake
  :custom
  (flymake-show-diagnostics-at-end-of-line 1)
  :hook
  (prog-mode . flymake-mode)
  (flymake-mode . eldoc-mode)
  :bind
  (:map flymake-mode-map
        ("M-n" . flymake-goto-next-error)
        ("M-p" . flymake-goto-prev-error)))

(setq flymake-fringe-indicator-position 'left-fringe)

;; Suppress the display of Flymake error counters when there are no errors.
(setq flymake-suppress-zero-counters t)

;; Disable wrapping around when navigating Flymake errors.
(setq flymake-wrap-around nil)
;; Go programming
(use-package go-mode
  :ensure t
  :bind (:map go-mode-map
	      ("C-c C-f" . 'gofmt))
  :hook (before-save . gofmt-before-save))

;; For json files
(use-package json-mode
  :ensure t)

;; Common lisp development
(use-package sly
  :ensure t)

;; Snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; Treesitter support
(use-package treesit-auto
  :ensure t
  :custom
  (setq treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Project management
(use-package project
  :bind (("C-x p f" . project-find-file)
         ("C-x p b" . project-switch-to-buffer)))

;; Packages for reading things
;; Epub
(use-package nov
  :ensure t
  :init (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;; PDF
(use-package pdf-tools
  :ensure t)

;;; UI
;; Padding mode
(use-package spacious-padding
  :ensure t
  :config
  (spacious-padding-mode 1))

;; Mood line
(use-package mood-line
  :ensure t
  :init
  (mood-line-mode))

;;; Keybindings
(global-set-key (kbd "C-x k") 'kill-this-buffer)  ; Close current buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)         ; Better buffer management
(global-set-key (kbd "M-o") 'other-window)        ; Switch windows easily

;;; Editing text
(use-package ace-jump-mode
  :ensure t
  :bind
  (("C-c SPC" . ace-jump-mode)  ;; Jump anywhere
   ("C-c j c" . ace-jump-char-mode)  ;; Jump to a specific character
   ("C-c j w" . ace-jump-word-mode)  ;; Jump to a word
   ("C-c j l" . ace-jump-line-mode)))

;; Org mode settings
(setq org-log-done 'time)
(setq org-agenda-files '("~/org/agenda.org"))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((js . t)))

;;; Note Taking
(use-package denote
  :ensure t
  :config
  (setq denote-directory (expand-file-name "~/Notes/")))
;;; init.el ends here
