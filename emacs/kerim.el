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

(defun my/enable-prettier-on-save ()
  (when (and (buffer-file-name)
             (my/find-local-prettier))
    (add-hook 'before-save-hook #'my/prettier-format-buffer nil t)))
