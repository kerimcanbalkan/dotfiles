(package! prettier-js)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Theme
(package! nov)
