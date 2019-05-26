;; DO NOT EDIT THIS FILE DIRECTLY
;; This is a file generated from a literate programing source file located at
;; https://github.com/dpsutton/tangled-emacs/blob/master/init.org.
;; You should make any changes there and regenerate it from Emacs org-mode using C-c C-v t

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in in %s with %d garbage collections"
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;(setq debug-on-error t)

(setq gc-cons-threshold most-positive-fixnum)

(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
 (load custom-file))

(customize-set-variable 'package-archives
                        '(("gnu"       . "https://elpa.gnu.org/packages/")
                          ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(require 'use-package)

(customize-set-variable 'use-package-always-ensure t)

(customize-set-variable 'use-package-verbose nil)

(customize-set-variable 'load-prefer-newer t)
(use-package auto-compile
  :defer nil
  :config (auto-compile-on-load-mode))

(server-start)

(defun shutdown-server ()
  "Kill the running emacs server.
When running emacs client, easily kill the server without ps aux,
pkill, etc."
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(use-package resize-window
  :bind
  ("C-c ;" . resize-window)
  ("C-c C-;" . resize-window)
  :config
  (add-hook 'org-mode-hook
            (lambda ()
              (bind-key "C-c ;" 'resize-window org-mode-map)))
  (resize-window-add-choice ?l #'ivy-switch-buffer "Switch buffers with ivy")
  (resize-window-add-choice ?a #'counsel-git "Search git files")
  (resize-window-add-choice ?h (lambda () (dired "~/projects/clojure"))
                            "Visit the clojure directory")
  (resize-window-add-choice ?u (lambda () (dired "~/ops/projects"))
                            "Work projects")
  (resize-window-add-choice ?d (lambda () (dired "~/projects/dev"))
                            "Visit dev directoryq")
  (resize-window-add-choice ?m (lambda () (resize-window--window-push))
                            "Push window state onto window stack"))

(setq ring-bell-function 'ignore)

(defun append-suffix (suffix phrases)
  "take SUFFIX and append it to each of the PHRASES."
  (mapcar #'(lambda (phrase) (concat (symbol-name phrase) suffix)) phrases))

(defun hook-up-modes (environments hook)
  (mapc (lambda (mode) (add-hook mode hook))
        (mapcar (lambda (env) (intern (format "%s-mode-hook" env)))
                environments)))

(customize-set-variable 'kill-whole-line t)

(customize-set-variable 'mouse-yank-at-point t)

(setq completion-ignore-case t)
(customize-set-variable 'read-file-name-completion-ignore-case t)
(customize-set-variable 'read-buffer-completion-ignore-case t)

(customize-set-variable 'show-trailing-whitespace t)

(show-paren-mode)

(customize-set-variable 'indent-tabs-mode nil)

(customize-set-variable 'backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(when (fboundp 'winner-mode) (winner-mode))

(use-package unfill
  :bind
  ("M-q" . unfill-toggle)
  ("A-q" . unfill-paragraph))

(use-package saveplace
  :defer nil
  :config
  (save-place-mode))

(use-package imenu-anywhere)

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(customize-set-variable 'ad-redefinition-action 'accept)

(require 'bind-key)

(when (>= emacs-major-version 26)
  (pixel-scroll-mode))

(use-package diminish
  :defer 1)

(use-package minions
  :config (minions-mode))

(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(use-package uniquify
  :defer 1
  :ensure nil
  :custom
  (uniquify-after-kill-buffer-p t)
  (uniquify-buffer-name-style 'post-forward)
  (uniquify-strip-common-suffix t))

(use-package smart-mode-line
  :defer 2)

(use-package hl-line
    :defer nil
    :config
    (global-hl-line-mode +1))

(use-package solarized-theme)
(use-package darktooth-theme)
(use-package kaolin-themes)
(use-package sublime-themes)
(use-package gruvbox-theme)
(load-theme 'gruvbox)

(use-package projectile
  :defer 2
  :diminish projectile-mode
  :config
  (projectile-global-mode))

(use-package which-key
  :defer nil
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package company
  :diminish company-mode
  :hook
  (after-init . global-company-mode))

(use-package all-the-icons)
(use-package neotree
  :config
  (customize-set-variable 'neo-theme (if (display-graphic-p) 'icons 'arrow))
  (customize-set-variable 'neo-smart-open t)
  ;;(customize-set-variable 'projectile-switch-project-action 'neotree-projectile-action)
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
  :bind
  ([f8] . neotree-project-dir))

(defvar my-text-environments '(org markdown))

(defun standard-text-environment ()
  (visual-line-mode)
  (whitespace-mode -1))

(hook-up-modes my-text-environments 'standard-text-environment)

(setq-default indent-tabs-mode nil)
(setq tab-width 8)

(use-package browse-kill-ring
  :config
  (browse-kill-ring-default-keybindings)
  :bind
  ("s-y" . browse-kill-ring))

(use-package undo-tree
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t))

(bind-key "C-+" 'text-scale-increase)
(bind-key "C--" 'text-scale-decrease)

(use-package org
  :bind
  ([remap org-toggle-comment] . resize-window))

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer))

(use-package pcre2el)
(use-package visual-regexp-steroids
  :custom
  (vr/engine 'pcre2el "Use PCRE regular expressions")
  :bind
  ("C-c r" . vr/replace)
  ("C-c q" . vr/query-replace)
  ("C-r"   . vr/isearch-backward)
  ("C-S-s" . vr/isearch-forward)
  ("C-M-s" . isearch-forward)
  ("C-M-r" . isearch-backward))

(use-package loccur
  :bind ("C-o" . loccur-current))

(defun personal/ag-at-point ()
  (interactive)
  (let ((current-word (thing-at-point 'symbol)))
    (counsel-ag current-word)))

(use-package ivy
  :bind
  ("C-c C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t))

(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-r" . personal/ag-at-point)
  ("C-x C-f" . counsel-find-file)
  ("C-x l" . counsel-locate)
  ("C-S-o" . counsel-rhythmbox)
  ("C-s" . swiper))

(use-package paredit)

(use-package rainbow-delimiters)

(use-package magit
  :bind ("C-x g" . magit-status))

(bind-key "C-c n" 'indent-region)

(use-package eldoc
  :diminish
  :hook
  (prog-mode . turn-on-eldoc-mode))

(use-package flycheck)

(use-package parseedn)
(use-package pkg-info)
(use-package queue)
(use-package spinner)
(use-package seq)
(use-package sesman)
(use-package flycheck-joker)

(use-package clojure-mode
  :load-path "~/projects/dev/clojure-mode"
  :config
  (setq clojure-indent-style 'align-arguments))

(use-package cider
  :load-path "~/projects/dev/cider"
  :config
  (setq cider-invert-insert-eval-p t)
  (setq cider-switch-to-repl-after-insert-p nil)
  (setq cider-switch-to-repl-on-insert-p nil)
  (setq clojure-toplevel-inside-comment-form t)
  (setq cider-font-lock-dynamically t)
  (setq cider-show-error-buffer nil)
  (setq cider-repl-display-help-banner nil)
  (setq cider-repl-pop-to-buffer-on-connect 'display-only)
  :bind (:map
         cider-repl-mode-map
         ("RET" . cider-repl-newline-and-indent)
         ("C-j" . cider-repl-return)
         :map
         paredit-mode-map
         ("C-j" . cider-repl-return)))

(defvar my-lisps '(clojure emacs-lisp cider-repl))
;; geiser geiser-repl racket scheme slime repl

(defun standard-lisp-environment ()
  (paredit-mode 1)
  (rainbow-delimiters-mode 1)
  (eldoc-mode 1))

(hook-up-modes my-lisps 'standard-lisp-environment)
