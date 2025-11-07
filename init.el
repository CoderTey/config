;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; -*- lexical-binding: t; -*-
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (dir '("/usr/bin" "/bin" "/usr/local/bin"))
  (when (file-directory-p dir)
    (add-to-list 'exec-path dir)))
(setenv "PATH" (string-join exec-path path-separator))
(defun ensure-package (pkg)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Evil mode
(ensure-package 'evil)
(require 'evil)
(evil-mode 1)

(ensure-package 'nord-theme)
(load-theme 'nord t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(setq show-paren-delay 0)
(electric-pair-mode 1)

(set-face-attribute 'default nil :height 140)

;; Undo-tree
(ensure-package 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode 1)
(evil-set-undo-system 'undo-tree)

(ensure-package 'company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

(ensure-package 'flycheck)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(ensure-package 'rust-mode)
(ensure-package 'rustic)
(require 'rust-mode)
(require 'rustic)
(add-hook 'rust-mode-hook #'eglot-ensure)
(setq rustic-format-on-save t)
(ensure-package 'eglot)
(require 'eglot)
(setq eglot-autoshutdown t)

(ensure-package 'magit)
(require 'magit)

;; Git
(ensure-package 'magit)
(require 'magit)

;; Cargo Run / Test
(defun my-rust-run ()
  (interactive)
  (save-buffer)
  (compile "cargo run"))
(defun my-rust-test ()
  (interactive)
  (save-buffer)
  (compile "cargo test"))
(global-set-key (kbd "<f5>") 'my-rust-run)
(global-set-key (kbd "<f6>") 'my-rust-test)


(ensure-package 'projectile)
(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(setq browse-url-browser-function 'browse-url-firefox)
(custom-set-variables
 '(package-selected-packages nil))
(custom-set-faces)

(use-package xclip
  :ensure t
  :config
  (setq xclip-program "wl-copy")
  (setq xclip-select-enable-clipboard t)
  (setq xclip-method 'wl-copy)
  (xclip-mode 1))

(evil-ex-define-cmd "gui-check" 
  (lambda ()
    (interactive)
    (if (display-graphic-p)
        (message "GUI Emacs")
      (message "Terminal Emacs"))))



;; init.el ends here
(ensure-package 'dap-mode)
(require 'dap-mode)
(require 'dap-gdb-lldb)
(dap-auto-configure-mode 1)
(setq dap-auto-show-output t)

(setq browse-url-browser-function 'browse-url-firefox)
(custom-set-variables
 '(package-selected-packages
   '(nord-theme company eglot magit undo-tree projectile dap-mode cmake-mode rust-mode rustic evil flycheck)))
(custom-set-faces)
