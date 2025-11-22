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

;; Theme
(rc/require 'autothemer)
(rc/require 'doom-themes)

(load-theme 'doom-nord-aurora t)

(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(custom-set-faces
 '(default ((t (:background "#3B4252" :foreground "#ECEFF4"))))  ; Более яркий фон
 '(font-lock-keyword-face ((t (:foreground "#81A1C1" :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "#88C0D0" :weight bold))))
 '(font-lock-variable-name-face ((t (:foreground "#D08770" :weight bold))))
 '(font-lock-string-face ((t (:foreground "#A3BE8C"))))
 '(font-lock-constant-face ((t (:foreground "#B48EAD" :weight bold))))
 '(font-lock-type-face ((t (:foreground "#8FBCBB" :weight bold))))
 '(font-lock-comment-face ((t (:foreground "#81A1C1" :slant italic))))
 '(font-lock-builtin-face ((t (:foreground "#88C0D0"))))
 '(font-lock-warning-face ((t (:foreground "#EBCB8B" :weight bold))))
 '(region ((t (:background "#5E81AC" :foreground "#ECEFF4"))))
 '(highlight ((t (:background "#5E81AC"))))
 '(hl-line ((t (:background "#434C5E"))))
 '(line-number ((t (:foreground "#81A1C1"))))
 '(line-number-current-line ((t (:foreground "#88C0D0" :weight bold))))
 '(mode-line ((t (:background "#2E3440" :foreground "#D8DEE9" :weight normal))))  ; Приглушённая mode-line
 '(mode-line-inactive ((t (:background "#242933" :foreground "#4C566A")))))  ; Ещё более тусклая неактивная

(package-initialize)
(setq package-install-upgrade-built-in t)
(add-to-list 'default-frame-alist `(font . "IosevkaNerdFont-18"))

;; Smex
(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Multiple Cursors
(rc/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;; Magit
(require 'seq)
(rc/require 'magit)
(setq magit-display-buffer-function
      #'magit-display-buffer-fullframe-status-v1)

;; Terminal
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

;; Flycheck
(rc/require 'flycheck)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Eglot
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
 '(custom-safe-themes
   '("5a4cdc4365122d1a17a7ad93b6e3370ffe95db87ed17a38a94713f6ffe0d8ceb"
     "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
     "3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b"
     "42a6583a45e0f413e3197907aa5acca3293ef33b4d3b388f54fa44435a494739"
     "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700"
     default))
 '(package-selected-packages
   '(autothemer company counsel-projectile dash-functional doom-themes
		evil flycheck fzf general gruber-darker-theme
		helm-ls-git ido-completing-read+ lsp-mode lua-mode
		magit multiple-cursors nix-mode nord-theme rustic smex
		tree-sitter-langs undo-tree vterm xclip)))
