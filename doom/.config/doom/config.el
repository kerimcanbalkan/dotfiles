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

;; Default shell
(setq-default explicit-shell-file-name "/bin/fish")

;; Tailwind lsp
(use-package! lsp-tailwindcss :after lsp-mode)
