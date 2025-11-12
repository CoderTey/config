(package-initialize)
(setq package-install-upgrade-built-in t)

;; Basic Settings
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(setq inhibit-startup-screen t)

;; Syntax highlighting
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

;; Line Number
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(setq show-paren-delay 0)
(electric-pair-mode 1)

;;; load-file
(load-file "~/rc.el")

;;; Theme for emacs
(rc/require-theme 'nord)

;;; Font for emacs
(add-to-list 'default-frame-alist `(font . "IosevkaNerdFont-18"))

;;; Completion for M-x
(rc/require 'smex 'ido-completing-read+)
(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; rust-mode
(rc/require 'rust-mode 'rustic)
(require 'rust-mode)
(require 'rustic)

(setq rustic-format-on-save t)

(setq-default rust-basic-offset 4
              rust-default-style '((java-mode . "java")
                                   (awk-mode . "awk")
                                   (other . "bsd")))

(add-hook 'rust-mode-hook (lambda ()
                            (interactive)
                            (rust-toggle-comment-style -1)))

;; Use tree-sitter for Rust if available
(when (treesit-available-p)
  (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode)))

;;; Multiple cursor
(rc/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; Magit
(require 'seq)
(rc/require 'magit)
(setq magit-display-buffer-function
      #'magit-display-buffer-fullframe-status-v1)

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


;;; evil
(rc/require 'evil 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode 1)

(setq evil-want-integration t)
(setq evil-want-keybinding nil)

(when (fboundp 'evil-set-undo-system)
  (evil-set-undo-system 'undo-tree))

(evil-mode 1)

;;; Whitespace handling
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(defun rc/set-up-eglot ()
  (interactive)
  (rc/set-up-whitespace-handling)
  (company-mode 1)
  (eglot-ensure))

(add-hook 'tuareg-mode-hook 'rc/set-up-eglot)
(add-hook 'c++-mode-hook 'rc/set-up-eglot)
(add-hook 'c-mode-hook 'rc/set-up-eglot)
(add-hook 'simpc-mode-hook 'rc/set-up-eglot)
(add-hook 'emacs-lisp-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-eglot)
(add-hook 'lua-mode-hook 'rc/set-up-eglot)
(add-hook 'rust-mode-hook 'rc/set-up-eglot)
(add-hook 'rustic-mode-hook 'rc/set-up-eglot)
(add-hook 'scala-mode-hook 'rc/set-up-eglot)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-eglot)
(add-hook 'python-mode-hook 'rc/set-up-eglot)
(add-hook 'erlang-mode-hook 'rc/set-up-eglot)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'fasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-eglot)
(add-hook 'nim-mode-hook 'rc/set-up-eglot)
(add-hook 'yaml-mode-hook 'rc/set-up-eglot)
(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)

;;; Nix mode
(rc/require 'nix-mode)
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(add-hook 'nix-mode-hook 'rc/set-up-eglot)

;;; Projectile
(rc/require 'projectile 'counsel-projectile)
(require 'projectile)
(require 'counsel-projectile)
(projectile-mode +1)
(counsel-projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;; Ivy/Counsel/Swiper - fzf-like fuzzy finding
(rc/require 'ivy 'counsel 'swiper)
(require 'ivy)
(require 'counsel)
(require 'swiper)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 15)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))  ;; Enable fuzzy matching everywhere

;; counsel-fzf uses actual fzf binary
(setq counsel-fzf-cmd "fzf -f \"%s\"")

;; Use rg for faster searching if available
(when (executable-find "rg")
  (setq counsel-rg-base-command "rg -S --no-heading --line-number --color never %s"))

;;; helm
(rc/require 'helm 'helm-ls-git)

(setq helm-ff-transformer-show-only-basename nil)
(global-set-key (kbd "C-c h t") 'helm-cmd-t)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h r") 'helm-recentf)

;;;Which Key
(rc/require 'which-key)
(require 'which-key)
(which-key-mode 1)

;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)

;;; Keybinds
(global-set-key (kbd "C-c e") 'eshell)

;; Evil leader key bindings with Counsel (fzf-like fuzzy finding)
(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "SPC f f") 'counsel-file-jump)
  (evil-define-key 'normal 'global (kbd "SPC f p") 'counsel-projectile-find-file)
  (evil-define-key 'normal 'global (kbd "SPC f g") 'counsel-git)
  (evil-define-key 'normal 'global (kbd "SPC f r") 'counsel-recentf)
  (evil-define-key 'normal 'global (kbd "SPC f d") 'counsel-find-file)
  (evil-define-key 'normal 'global (kbd "SPC s s") 'swiper)
  (evil-define-key 'normal 'global (kbd "SPC s g") 'counsel-rg)
  (evil-define-key 'normal 'global (kbd "SPC s p") 'counsel-projectile-rg)
  (evil-define-key 'normal 'global (kbd "SPC b b") 'counsel-switch-buffer))

;;; vterm
(rc/require 'vterm)
(require 'vterm)
(global-set-key (kbd "C-c t") 'vterm)
(setq vterm-max-scrollback 10000)

;;; Browser
(setq browse-url-browser-function 'browse-url-firefox)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
