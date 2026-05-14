;;; Code:
(defun efs/configure-window-by-class ()
  (interactive)
  (pcase exwm-class-name
    ("Firefox" (exwm-workspace-move-window 3))
    ("mpv" (exwm-floating-toggle-floating)
     (exwm-layout-toggle-mode-line))))

(defun efs/exwm-init-hook ()
  ;; Make workspace 1 be the one where we land at startup
  (exwm-workspace-switch-create 1)

  ;; Open eshell by default
  (eshell)

  ;; Show battery status in the mode line
  (display-battery-mode 1)

  ;; Show the time and date in modeline
  (setq display-time-day-and-date t)
  (display-time-mode 1))

(use-package exwm
  :ensure t
  :config
  ;; Manage window rules
  (add-hook 'exwm-manage-finish-hook #'efs/configure-window-by-class)

  ;; Initialize
  (add-hook 'exwm-init-hook #'efs/exwm-init-hook)

  (setq exwm-workspace-number 6)

  ;; Configure global keys
  (setq exwm-input-prefix-keys
        '(?\C-x
          ?\C-u
          ?\C-g
          ?\C-h
          ?\M-x
          ?\M-`
          ?\M-&
          ?\M-:
          XF86AudioLowerVolume
          XF86AudioRaiseVolume
          XF86AudioMute
          XF86MonBrightnessUp
          XF86MonBrightnessDown
          XF86AudioPlay
          XF86AudioPrev
          XF86AudioNext
          ?\C-\M-j  ;; Buffer list
          ?\C-\ ))  ;; Ctrl+Space

  ;; Ctrl+Q will enable the next key to be sent directly
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  (setq exwm-input-simulation-keys
        '(
          ;; movement
          ([?\C-b] . [left])
          ([?\M-b] . [C-left])
          ([?\C-f] . [right])
          ([?\M-f] . [C-right])
          ([?\C-p] . [up])
          ([?\C-n] . [down])
          ([?\C-a] . [home])
          ([?\C-e] . [end])
          ([?\M-v] . [prior])
          ([?\C-v] . [next])
          ([?\C-d] . [delete])
          ([?\C-k] . [S-end delete])
          ;; cut/paste.
          ([?\C-w] . [?\C-x])
          ([?\M-w] . [?\C-c])
          ([?\C-y] . [?\C-v])
          ;; search
          ([?\C-s] . [?\C-f])))

  ;; Rename apps on the buffer list
  ;; By default all apps are named EXWM which is too annoying.
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                          (string= "gimp" exwm-instance-name))
                (exwm-workspace-rename-buffer exwm-class-name))))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (when (or (not exwm-instance-name)
                        (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                        (string= "gimp" exwm-instance-name))
                (exwm-workspace-rename-buffer exwm-title))))

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
  (setq exwm-input-global-keys
        `(
          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Move between windows
          ([?\s-h] . windmove-left)
          ([?\s-l] . windmove-right)
          ([?\s-k] . windmove-up)
          ([?\s-j] . windmove-down)
          ([?\s-o] . other-window)
          (,(kbd "s-<return>") .
           (lambda ()
             (interactive)
             (start-process "st-terminal" nil "st"))
           )

          ;; Launch applications via shell command
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
                       (start-process-shell-command command nil command)))

          ([?\s-p] . app-launcher-run-app)

          ;; Switch workspace
          ([?\s-w] . exwm-workspace-switch)

          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))))

  (defvar my-modeline-status "" "Variable to hold battery and volume info.")

  (defun update-my-modeline-status ()
    "Fetch battery and volume to update my-modeline-status."
    (let ((bat (shell-command-to-string "upower -i $(upower -e | grep 'BAT') | grep -E 'percentage' | awk '{print $2}'"))
          (vol (shell-command-to-string "pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume/ {print $5}'")))
      (setq my-modeline-status
            (format "Bat: %s%%  Vol: %s%%" (string-trim bat) (string-trim vol)))))

  ;; Update status every 10 seconds
  (run-with-timer 0 10 'update-my-modeline-status)

  (setq-default mode-line-format
                '((:eval
                   (let* ((branch (when vc-mode (string-trim (substring vc-mode 5))))
                          (mode-str (format-mode-line mode-name))
                          (mode (if (> (length mode-str) 12)
                                    (format "[%s…]" (substring mode-str 0 10))
                                  (format "[%s]" mode-str)))
                          ;; Left side
                          (left (format " %s %s%s %s "
                                        (buffer-name)
                                        (if branch " " "")
                                        (or branch "")
                                        mode))
                          ;; Right side - Use %S for seconds
                          (time-str (format-time-string "%d-%m-%Y %H:%M:%S"))
                          (right (format "%s  %s" (or (and (boundp 'my-modeline-status) my-modeline-status) "") time-str)))

                     (concat left
                             (propertize " " 'display `(space :align-to (- right ,(length right))))
                             right)))))

  ;; Essential for the seconds to actually tick:
  (setq display-time-interval 1)
  (display-time-mode 1)

  (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
  (add-to-list 'default-frame-alist '(alpha . (90 . 90)))
  (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))

  (exwm-wm-mode))


(use-package xdg-launcher
  :vc (:url "https://github.com/emacs-exwm/xdg-launcher"))

(use-package desktop-environment
  :ensure t
  :config
  (desktop-environment-mode))
;;; exwm.el ends here
