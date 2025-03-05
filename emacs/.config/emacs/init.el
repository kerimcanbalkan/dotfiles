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

;; Color theme
(setq modus-themes-bold-constructs t)
(setq modus-themes-italic-constructs t)
(setq modus-themes-mode-line '(borderless))
(setq modus-themes-syntax '(faint alt-syntax green-strings yellow-comments))
(setq modus-themes-headings
      (quote ((1 . (variable-pitch 1.5))
              (2 . (rainbow 1.3))
              (3 . (1.1))
              (t . (monochrome)))))
(setq modus-themes-mixed-fonts t)

(load-theme 'modus-vivendi)

;; Automatically reread from disk if the underlying files changes
(setopt auto-revert-avoid-polling t)

;; Font
(set-face-attribute 'default nil :font "RobotoMono Nerd Font" :height 140)

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
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
      ;; I'll add an extra note here since user customizations are important.
      ;; Emacs actually offers a UI-based customization menu, "M-x customize".
      ;; You can use this menu to change variable values across Emacs. By default,
      ;; changing a variable will write to your init.el automatically, mixing
      ;; your hand-written Emacs Lisp with automatically-generated Lisp from the
      ;; customize menu. The following setting instead writes customizations to a
      ;; separate file, custom.el, to keep your init.el clean.
      custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Bring in package utilities so we can install packages from the web.
(require 'package)

;; Add MELPA, an unofficial (but well-curated) package registry to the
;; list of accepted package registries. By default Emacs only uses GNU
;; ELPA and NonGNU ELPA, https://elpa.gnu.org/ and
;; https://elpa.nongnu.org/ respectively.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Unless we've already fetched (and cached) the package archives,
;; refresh them.
(unless package-archive-contents
  (package-refresh-contents))

;; Add the :vc keyword to use-package, making it easy to install
;; packages directly from git repositories.
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

;; Minibuffer and completion

;; Vertico: better vertical completion for minibuffer commands
(use-package vertico
  :ensure t
  :init
  ;; You'll want to make sure that e.g. fido-mode isn't enabled
  (vertico-mode))

(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map
              ("<backspace>" . vertico-directory-delete-word)))

;; Marginalia: annotations for minibuffer
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; Popup completion-at-point
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  ;; You may want to play with delay/prefix/styles to suit your preferences.
  (corfu-auto-delay 0)
  (corfu-auto-prefix 0)
  (completion-styles '(orderless basic)))


;; Part of corfu
(use-package corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config
  (corfu-popupinfo-mode))

;; Make corfu popup come up in terminal overlay
(use-package corfu-terminal
  :if (not (display-graphic-p))
  :ensure t
  :config
  (corfu-terminal-mode))

;; Fancy completion-at-point functions; there's too much in the cape package to
;; configure here; dive in when you're comfortable!
(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; Pretty icons for corfu
(use-package kind-icon
  :if (display-graphic-p)
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


;; Orderless: powerful completion style
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

;; Adds LSP support. Note that you must have the respective LSP
;; server installed on your machine to use it with Eglot. e.g.
;; rust-analyzer to use Eglot with `rust-mode'.
(use-package eglot
  :ensure t
  :bind (("s-<mouse-1>" . eglot-find-implementation)
         ("C-c ." . eglot-code-action-quickfix))
  ;; Add your programming modes here to automatically start Eglot,
  ;; assuming you have the respective LSP server installed.
  :hook ((go-mode . eglot-ensure)
         (web-mode . eglot-ensure))
  :config
  ;; You can configure additional LSP servers by modifying
  ;; `eglot-server-programs'. The following tells eglot to use TypeScript
  ;; language server when working in `web-mode'.
  (add-to-list 'eglot-server-programs
               '(web-mode . ("typescript-language-server" "--stdio"))
               '(web-mode . ("tailwindcss-language-server" "--stdio"))))

;; Flymake configurations
(use-package flymake
  :ensure nil ;; Flymake is built into Emacs, so no need to install it
  :custom
  (flymake-show-diagnostics-at-end-of-line 1)
  :hook
  (prog-mode . flymake-mode)
  (flymake-mode . eldoc-mode)
  :bind
  (:map flymake-mode-map
        ("M-n" . flymake-goto-next-error)
        ("M-p" . flymake-goto-prev-error)))

;; Add extra context to Emacs documentation to help make it easier to
;; search and understand. This configuration uses the keybindings 
;; recommended by the package author.
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

;; As you've probably noticed, Lisp has a lot of parentheses.
;; Maintaining the syntactical correctness of these parentheses
;; can be a pain when you're first getting started with Lisp,
;; especially when you're fighting the urge to break up groups
;; of closing parens into separate lines. Luckily we have
;; Paredit, a package that maintains the structure of your
;; parentheses for you. At first, Paredit might feel a little
;; odd; you'll probably need to look at a tutorial (linked
;; below) or read the docs before you can use it effectively.
;; But once you pass that initial barrier you'll write Lisp
;; code like it's second nature.
;; http://danmidwood.com/content/2014/11/21/animated-paredit.html
;; https://stackoverflow.com/a/5243421/3606440
(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . enable-paredit-mode)
         (lisp-mode . enable-paredit-mode)
         (ielm-mode . enable-paredit-mode)
         (lisp-interaction-mode . enable-paredit-mode)
         (scheme-mode . enable-paredit-mode)))

(use-package go-mode
  :ensure t
  :bind (:map go-mode-map
	      ("C-c C-f" . 'gofmt))
  :hook (before-save . gofmt-before-save))

;; TypeScript, JS, and JSX/TSX support.
(use-package web-mode
  :ensure t
  :mode (("\\.ts\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.mjs\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :custom
  (web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-enable-auto-quoting nil))

;; Snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; Treesitter support
(use-package treesit-auto
  :ensure t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

;; Typescript support
(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'" . typescript-mode)
  :hook (typescript-mode . eglot-ensure))

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

;; Padding mode
(use-package spacious-padding
  :ensure t
  :config
  (spacious-padding-mode 1))

;; Keybinds
(global-set-key (kbd "C-x k") 'kill-this-buffer)  ; Close current buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)         ; Better buffer management
(global-set-key (kbd "M-o") 'other-window)        ; Switch windows easily

;; Editing text
(use-package ace-jump-mode
  :ensure t
  :bind
  (("C-c SPC" . ace-jump-mode)  ;; Jump anywhere
   ("C-c j c" . ace-jump-char-mode)  ;; Jump to a specific character
   ("C-c j w" . ace-jump-word-mode)  ;; Jump to a word
   ("C-c j l" . ace-jump-line-mode)))

;;; init.el ends here
