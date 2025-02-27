
;; User info
(setq user-full-name "Kerimcan Balkan"
      user-mail-address "kerimcanbalkan@gmail.com")

;; Color theme
(setq doom-theme 'doom-nord)

;; Line numbers
(setq display-line-numbers-type t)

;; remove top frame bar in emacs
(add-to-list 'default-frame-alist '(undecorated . t))

;; Org Directory
(setq org-directory "~/org/")

;; Font
(setq doom-font (font-spec :family "RobotoMono Nerd Font" :size 16))

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

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

;; Short splash
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)
(setq dashboard-footer-icon "")


(defun my-weebery-is-always-greater ()
  (let* ((banner '("GNU Emacs"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

;; Keybindings
(map! :after magit "C-c C-g" #'magit-status)
(map! "M-g g" #'avy-goto-line)


;; Performance
(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.5
      lsp-log-io nil)

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

;; Tailwind
(use-package! lsp-tailwindcss
  :after
  lsp-mode
  :init
  (setq lsp-tailwindcss-add-on-mode t))

;; Golang stuff
(after! lsp-mode
  (setq  lsp-go-use-gofumpt t)
  )
;; automatically organize imports
(add-hook 'go-mode-hook #'lsp-deferred)
;; Make sure you don't have other goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; enable all analyzers; not done by default
(after! lsp-mode
  (setq  lsp-go-analyses '((fieldalignment . t)
                           (nilness . t)
                           (shadow . t)
                           (unusedparams . t)
                           (unusedwrite . t)
                           (useany . t)
                           (unusedvariable . t)))
  )
