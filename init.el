;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; A clean, modern Emacs setup for Rust, Nix, and Lua development
;;; Code:

;; ============================================================================
;; PACKAGE MANAGEMENT
;; ============================================================================

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Refresh package list if needed
(unless package-archive-contents
  (package-refresh-contents))

;; Add common binary paths
(dolist (dir '("/usr/bin" "/bin" "/usr/local/bin"))
  (when (file-directory-p dir)
    (add-to-list 'exec-path dir)))
(setenv "PATH" (string-join exec-path path-separator))

;; Helper function to install packages
(defun ensure-package (pkg)
  "Install PKG if not already installed."
  (unless (package-installed-p pkg)
    (package-install pkg)))

(ensure-package 'use-package)
(require 'use-package)
(setq use-package-always-ensure t)


;; ============================================================================
;; VISUAL SETTINGS
;; ============================================================================

;; Theme
(ensure-package 'nord-theme)
(load-theme 'nord t)

;; Clean UI - no bars or startup screen
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; Editor enhancements
(global-display-line-numbers-mode 1)  ; Line numbers
(show-paren-mode 1)                   ; Highlight matching parentheses
(setq show-paren-delay 0)
(electric-pair-mode 1)                ; Auto-close brackets
(set-face-attribute 'default nil :height 140)  ; Larger font

;; ============================================================================
;; EVIL MODE (Vim keybindings)
;; ============================================================================

(ensure-package 'evil)
(require 'evil)
(evil-mode 1)


;; Undo system for Evil
(ensure-package 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode 1)
(evil-set-undo-system 'undo-tree)

;; ============================================================================
;; COMPLETION & SYNTAX CHECKING
;; ============================================================================

;; Company - autocompletion framework
(ensure-package 'company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1   ; Show completions after 1 character
      company-idle-delay 0.0)           ; No delay

;; Flycheck - on-the-fly syntax checking
(ensure-package 'flycheck)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Eglot - LSP client for modern IDE features
(ensure-package 'eglot)
(require 'eglot)
(setq eglot-autoshutdown t)  ; Stop LSP servers when buffer is closed

;; ============================================================================
;; RUST DEVELOPMENT
;; ============================================================================

(ensure-package 'rust-mode)
(ensure-package 'rustic)
(require 'rust-mode)
(require 'rustic)

;; Enable LSP for Rust (requires rust-analyzer)
(add-hook 'rust-mode-hook #'eglot-ensure)
(setq rustic-format-on-save t)  ; Auto-format with rustfmt

;; Keybindings for Rust
(defun my-rust-run ()
  "Save and run current Rust project."
  (interactive)
  (save-buffer)
  (compile "cargo run"))

(defun my-rust-test ()
  "Save and test current Rust project."
  (interactive)
  (save-buffer)
  (compile "cargo test"))

(global-set-key (kbd "<f5>") 'my-rust-run)
(global-set-key (kbd "<f6>") 'my-rust-test)

;; ============================================================================
;; NIX DEVELOPMENT
;; ============================================================================

(ensure-package 'nix-mode)
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

;; Use nixd for LSP - provides completion for:
;;   - NixOS packages (pkgs.firefox, pkgs.xorg.*, etc.)
;;   - NixOS options (services.xserver.enable, etc.)
;;   - System configuration options
;; Install: nix-env -iA nixpkgs.nixd
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(nix-mode . ("nixd"))))

;; Enable LSP for Nix files
(add-hook 'nix-mode-hook #'eglot-ensure)

;; Optional: Auto-format Nix files on save
;; Requires nixpkgs-fmt or alejandra formatter
;; (add-hook 'nix-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook 'eglot-format-buffer nil t)))

;; ============================================================================
;; LUA DEVELOPMENT
;; ============================================================================

(ensure-package 'lua-mode)
(require 'lua-mode)
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))

;; Use lua-language-server for LSP
;; Provides: completion, diagnostics, go-to-definition, hover docs
;; Install: Download from https://github.com/LuaLS/lua-language-server/releases
;;          Or via package manager (e.g., nix-env -iA nixpkgs.lua-language-server)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(lua-mode . ("lua-language-server"))))

;; Enable LSP for Lua files
(add-hook 'lua-mode-hook #'eglot-ensure)

;; ============================================================================
;; PROJECT MANAGEMENT
;; ============================================================================

;; Projectile - project navigation and management
(ensure-package 'projectile)
(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Magit - Git interface
(ensure-package 'magit)
(require 'magit)

;; ============================================================================
;; TERMINAL EMULATOR
;; ============================================================================

;; vterm - fast terminal emulator
;; Requires: cmake, libtool, libvterm
(ensure-package 'vterm)
(require 'vterm)

;; Keybinding to open vterm
(global-set-key (kbd "C-c t") 'vterm)

;; vterm settings
(setq vterm-max-scrollback 10000)  ; Scrollback buffer size

;; ============================================================================
;; SYSTEM INTEGRATION
;; ============================================================================

;; Use Firefox as default browser
(setq browse-url-browser-function 'browse-url-firefox)

;; Clipboard integration (for Wayland)
(use-package xclip
  :ensure t
  :config
  (setq xclip-program "wl-copy")
  (setq xclip-select-enable-clipboard t)
  (setq xclip-method 'wl-copy)
  (xclip-mode 1))

;; ============================================================================
;; CUSTOM COMMANDS
;; ============================================================================

;; Check if running in GUI or terminal
(evil-ex-define-cmd "gui-check" 
  (lambda ()
    (interactive)
    (if (display-graphic-p)
        (message "GUI Emacs")
      (message "Terminal Emacs"))))

;; ============================================================================
;; PACKAGE REGISTRY (auto-managed by Emacs)
;; ============================================================================

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

;;; init.el ends here
