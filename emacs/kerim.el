(defvar my-light-theme 'modus-operandi
  "The light theme to be used in toggle.")

(defvar my-dark-theme 'modus-vivendi
  "The dark theme to be used in toggle.")

(defun my/toggle-theme ()
  "Toggle between my preferred light and dark themes."
  (interactive)
  (if (equal (car custom-enabled-themes) my-light-theme)
      (progn
        (disable-theme my-light-theme)
        (load-theme my-dark-theme t))
    (progn
      (disable-theme my-dark-theme)
      (load-theme my-light-theme t))))

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
