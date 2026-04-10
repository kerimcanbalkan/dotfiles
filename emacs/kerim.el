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

;; Don't lose layout using C-x 1
(winner-mode +1)

(defun toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key (kbd "C-x 1") #'toggle-delete-other-windows)
