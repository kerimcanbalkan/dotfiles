(setq user-full-name "Kerimcan Balkan"
      user-mail-address "kerimcanbalkan@protonmail.com")

;; Color theme
(setq doom-theme 'doom-gruvbox)

;; Relative line numbers
(setq display-line-numbers-type 'relative)

;; Font
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))

;; Org directory
(setq org-directory "~/Notes/")

;; Projectile projects location unfortunately it does not find projects I don't know why!
(setq projectile-project-search-path '("~/Projects/" "~/work/" "~/other-projects/"))

;; Evil mode set insert cursor
(setq evil-insert-state-cursor '(bar . 2))

;; Tweaks that I copied from jblais's config
;; Performance optimizations
(setq gc-cons-threshold (* 256 1024 1024))
(setq read-process-output-max (* 4 1024 1024))
(setq comp-deferred-compilation t)
(setq comp-async-jobs-number 8)

;; Garbage collector optimization
(setq gcmh-idle-delay 5)
(setq gcmh-high-cons-threshold (* 1024 1024 1024))

;; Version control optimization
(setq vc-handled-backends '(Git))

;; Fix x11 issues
(setq x-no-window-manager t)
(setq frame-inhibit-implied-resize t)
(setq focus-follows-mouse nil)

;; Setup custom splashscreen
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(setq fancy-splash-image "~/Pictures/Wallpapers/doom-emacs-dark.svg")
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Welcome to Emacs")))

;; Speed of which-key popup
(setq which-key-idle-delay 0.2)

;; Evil-escape sequence
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.1)

;; LSP Performance optimizations and settings
(after! lsp-mode
  (setq lsp-idle-delay 0.5
        lsp-log-io nil
        lsp-completion-provider :capf
        lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-text-document-color nil
        lsp-enable-on-type-formatting nil
        lsp-enable-snippet nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-links nil))

;; LSP UI settings for better performance
(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 72
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-delay 0.5
        lsp-ui-sideline-enable nil
        lsp-ui-peek-enable t))

(use-package! svelte-mode
  :mode "\\.svelte\\'"
  :config
  (setq svelte-basic-offset 2)
  ;; Disable automatic reformatting
  (setq svelte-format-on-save nil)
  ;; Use prettier instead
  (add-hook 'svelte-mode-hook 'prettier-js-mode))

;; Configure prettier
(use-package! prettier-js
  :config
  (setq prettier-js-args
        '("--parser" "svelte"
          "--tab-width" "2"
          "--use-tabs" "true")))

(use-package! lsp-tailwindcss
  :after lsp-mode
  :init
  (setq lsp-tailwindcss-add-on-mode t))

(after! lsp-mode
  ;; Typescript language server (tsserver)
  (setq lsp-clients-typescript-server-args '("--stdio")))
