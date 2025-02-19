(setq user-full-name "Kerimcan Balkan"
      user-mail-address "kerimcanbalkan@gmail.com")

;; Remove top frame bar
(add-to-list 'default-frame-alist '(undecorated . t))
;; Set color scheme
(setq doom-theme 'doom-gruvbox)

;; Display line numbers
(setq display-line-numbers-type t)

;; Set org directory
(setq org-directory "~/org/")

;; Font
(setq doom-font (font-spec :family "RobotoMono Nerd Font" :size 12.0))

;; Tailwind lsp
(use-package! lsp-tailwindcss :after lsp-mode)

;; Dashboard
(setq fancy-splash-image "~/.config/doom/splash.png")

(setq-default vterm-shell "/bin/fish")
(setq-default explicit-shell-file-name "/bin/fish")

                                        ; Line wrap
(global-visual-line-mode t)

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

;; trash files before deleting
(setq delete-by-moving-to-trash t)
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
        lsp-enable-links nil

        ;; Go-specific settings
        lsp-go-hover-kind "Synopsis"
        lsp-go-analyses '((fieldalignment . t)
                          (nilness . t)
                          (unusedwrite . t)
                          (unusedparams . t))

        ;; Register custom gopls settings
        lsp-gopls-completeUnimported t
        lsp-gopls-staticcheck t
        lsp-gopls-analyses '((unusedparams . t)
                             (unusedwrite . t))))

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

;; Company mode tweaks
(after! company
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-show-quick-access t
        company-tooltip-limit 20
        company-tooltip-align-annotations t)
  ;; Add file path completion
  (add-to-list 'company-backends 'company-files)
  (setq company-files-exclusions nil)
  (setq company-files-chop-trailing-slash t))

;; Tailwind CSS
(use-package! lsp-tailwindcss)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(96 . 97))
(add-to-list 'default-frame-alist '(alpha . (96 . 97)))

;; Blink cursor
(blink-cursor-mode 1)

(projectile-discover-projects-in-directory "~/Projects/")


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
(after! lsp-mode
  (setq lsp-javascript-server 'ts-ls))
