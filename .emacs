;; Basic Settings
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(electric-pair-mode 1)
(setq inhibit-startup-screen t)

;; Completion for M-x
(ido-mode 1)
(ido-everywhere 1)

;; Line Number
(column-number-mode 1)
(global-display-line-numbers-mode 1)

(load-file "~/rc.el")






(rc/require 'autothemer)


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/rose-pine-emacs")


(load-theme 'rose-pine-moon t)  



(package-initialize)
(setq package-install-upgrade-built-in t)

(add-to-list 'default-frame-alist `(font . "IosevkaNerdFont-18"))

(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(rc/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(require 'seq)
(rc/require 'magit)
(setq magit-display-buffer-function
      #'magit-display-buffer-fullframe-status-v1)


(rc/require 'vterm)
(global-set-key (kbd "C-c t") 'vterm)
(global-set-key (kbd "C-c e") 'eshell)


;;; Completion + lsp
(rc/require 'company)
(require 'company)

(setq company-minimum-prefix-length 1
      company-idle-delay 0.2
      company-tooltip-align-annotations t)

(add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection))

(rc/require 'flycheck)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(rc/require 'eglot)
(require 'eglot)
(setq eglot-autoshutdown t)


(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(rust-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs
               '(rustic-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs
               '(nix-mode . ("nixd"))))

(defun rc/global-eglot-ensure ()
  "Start Eglot automatically in all programming buffers that support it."
  (when (and (derived-mode-p 'prog-mode)
             (not (eglot-managed-p)))
    (ignore-errors
      (eglot-ensure))))

(add-hook 'prog-mode-hook #'rc/global-eglot-ensure)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
