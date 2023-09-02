;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; use-package
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Global settings
(load-theme 'deeper-blue)

(blink-cursor-mode 0)
(column-number-mode t)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode t)
(tool-bar-mode 0)
(tooltip-mode 0)

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(fset 'yes-or-no-p 'y-or-n-p)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq gc-cons-threshold 20000000)
(setq read-process-output-max (* 1024 1024))
(setq-default indent-tabs-mode nil)

;; Some missing emacs modes
(use-package haskell-mode)

(use-package yaml-mode)

;; Emacs wise completions
(use-package smex
  :bind ("M-x" . smex))

(use-package flx-ido
  :config
  (flx-ido-mode 1))

;; Project wise operations (open, find, replace, etc...)
(use-package projectile
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (projectile-mode 1)
  (setq projectile-use-git-grep t)
  (setq projectile-sort-order 'recently-active)
  (setq projectile-project-search-path '(("~/projects/" . 1))))

;; Git Integration
(use-package magit
  :bind ("C-x g" . magit-status)
  :init
  (setq magit-repository-directories (quote (("~/projects" . 1))))
  (setq initial-buffer-choice (quote magit-list-repositories))
  (with-eval-after-load 'transient (transient-bind-q-to-quit)))

;; LSP
;; (use-package lsp-mode
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (js-mode . lsp)
;;          (web-mode . lsp)
;;          (go-mode . lsp))
;;   :commands lsp)

(use-package eglot
  :hook ((js-mode . eglot-ensure)
         (web-mode . eglot-ensure)
         (go-mode . eglot-ensure))
  ;;:config
  ;;(add-to-list 'eglot-server-programs '(web-mode "typescript-language-server" "--stdio"))
  :bind (:map eglot-mode-map
              (("C-c C-r" . eglot-rename)
               ("M-." . xref-find-definitions))))

;; Go
(use-package go-mode
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

;; Code Snippets
(use-package yasnippet
  :config
  (yas-global-mode 1)
  (use-package yasnippet-snippets))

;; Code Completions
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.0)
  (setq company-minimum-prefix-length 1))

;; JS
(use-package js
  :mode ("\\.[c|m]?js[x]?\\'" . js-mode))

;; (use-package web-mode
;;   :mode "\\.ts[x]?\\'")

(use-package prettier-js
  :hook ((js-mode . prettier-js-mode)
         (web-mode . prettier-js-mode)))

;; (use-package add-node-modules-path
;;   :hook (js-mode web-mode))

(use-package mocha)

;; Python
(use-package anaconda-mode
  :hook ((python-mode)
         (python-mode . anaconda-eldoc-mode)))

(use-package blacken
  :hook (python-mode . blacken-mode))

(use-package isortify
  :hook (python-mode . isortify-mode))

(use-package company-anaconda
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; Docker
(use-package docker :bind ("C-c d" . docker))
(use-package dockerfile-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(base16-monokai))
 '(custom-safe-themes
   '("882d6a5981fd85d9f987d31623e25e69b8d5635a53ab442f1a51e7c252790320" "50df89547dead6f5171c1d7eb0613635e2b06cf428b150b083c148f0c978d249" default))
 '(magit-commit-ask-to-stage nil)
 '(package-selected-packages
   '(graphviz-dot-mode graphql-mode svelte-mode nix-mode markdown-mode base16-theme eglot go-mode nginx-mode jenkinsfile-mode isortify blacken dockerfile-mode docker mocha prettier-js web-mode sbt-mode scala-mode flycheck company-restclient restclient company-anaconda company yasnippet-snippets yasnippet magit projectile flx-ido smex yaml-mode haskell-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
