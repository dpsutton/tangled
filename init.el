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

(setq personal/original-gc-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)

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

(setq dired-listing-switches "-alh")

(server-start)

(defun shutdown-server ()
  "Kill the running emacs server.
When running emacs client, easily kill the server without ps aux,
pkill, etc."
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(use-package resize-window
  :demand t
  :bind
  ("C-c ;" . resize-window)
  ("C-c C-;" . resize-window)
  :config
  (add-hook 'org-mode-hook
            (lambda ()
              (bind-key "C-c ;" 'resize-window org-mode-map)))
  (setq resize-window-swap-capital-and-lowercase-behavior t)
  (resize-window-add-choice ?l #'consult-buffer "Switch buffers with consult")
  (resize-window-add-choice ?a #'projectile-find-file "Projectile find file")
  (resize-window-add-choice ?h (lambda () (dired "~/projects/clojure"))
                            "Visit the clojure directory")
  (resize-window-add-choice ?u (lambda () (dired "~/projects/work/metabase"))
                            "Visit the work directory")
  (resize-window-add-choice ?d (lambda () (dired "~/projects/dev"))
                            "Visit dev directoryq")
  (resize-window-add-choice ?m (lambda () (resize-window--window-push))
                            "Push window state onto window stack")
  (resize-window-add-choice ?v (lambda () (find-file "~/projects/projects.org"))
                            "Edit project file")
  (resize-window-add-choice ?j (lambda () (crux-transpose-windows 1)) "Swap window positions"))

(setq visible-bell nil
      ring-bell-function 'flash-mode-line)
(defun flash-mode-line ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))

(global-auto-revert-mode t)

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

(add-hook 'prog-mode-hook (lambda () (setq-local show-trailing-whitespace t)))

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

(use-package imenu-anywhere
  :bind ("M-i" . imenu))

(use-package smooth-scrolling
  :disabled
  :config
  (smooth-scrolling-mode 1))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(customize-set-variable 'ad-redefinition-action 'accept)

(require 'bind-key)

(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(defconst personal/osx-p (string= system-type "darwin"))

(defconst personal/linux-machine (string= system-name "pop-os"))
(defconst personal/mac-machine (string= system-name "dan-mbp.local"))

(defconst personal/work-machine (string= system-name "dan-aclaimant-mbp.local"))

(when (>= emacs-major-version 26)
  (pixel-scroll-mode))

(use-package diminish
  :defer 1)

;; (use-package minions
;;   :config (minions-mode)
;;   (add-to-list 'minions-direct 'inf-clojure-minor-mode)
;;   (add-to-list 'minions-whitelist '(inf-clojure-minor-mode)))

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

(tool-bar-mode -1)

(setq custom-file (make-temp-file ""))
(setq custom-safe-themes t)
(setq enable-local-variables :all)

(defun personal/random-theme ()
  (interactive)
  (let* ((themes (custom-available-themes))
         (theme (symbol-name (nth (cl-random (length themes)) themes))))
    (message "Loading: %s" theme)
    (counsel-load-theme-action theme)))

(bind-key "C-c l" #'personal/random-theme)

(use-package solarized-theme)
(use-package kaolin-themes)
(use-package sublime-themes)

(use-package gruvbox-theme)
(load-theme 'doom-spacegrey)
;; (set-face-foreground 'highlight "black")
;; (set-face-background 'highlight "LightBlue")

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

(use-package hydra)

(use-package crux
  :bind
  ([remap kill-whole-line] . crux-kill-whole-line)
  ("C-c n" . crux-cleanup-buffer-or-region)
  ("C-M-z" . crux-indent-defun)
  ("C-c t" . crux-visit-term-buffer)
  ("C-a" . crux-move-beginning-of-line)
  :config
  (require 'crux)
  (crux-with-region-or-line kill-region))

(use-package company
  :diminish company-mode
  :bind ("TAB" . company-indent-or-complete-common)
  :hook
  (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 3))

(use-package company-quickhelp
  :init (company-quickhelp-mode)
  :config
  (setq company-quickhelp-use-propertized-text t)
  (setq company-quickhelp-delay 2.0))

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

(use-package all-the-icons)

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(defvar my-text-environments '(org markdown))

(defun standard-text-environment ()
  (visual-line-mode)
  (whitespace-mode -1))

(hook-up-modes my-text-environments 'standard-text-environment)

(setq-default indent-tabs-mode nil)
(setq tab-width 8)

(setq scroll-conservatively 101)

(use-package browse-kill-ring
  :demand t
  :config
  (browse-kill-ring-default-keybindings)
  :bind
  ("s-y" . browse-kill-ring))

(delete-selection-mode 1)

(use-package undo-tree
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t))

(bind-key "C-+" 'text-scale-increase)
(bind-key "C--" 'text-scale-decrease)

(use-package pdf-tools
  :demand t
  :config
  (require 'pdf-tools)
  (require 'pdf-view)
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("h" . image-backward-hscroll)
              ("l" . image-forward-hscroll)))

(use-package org
  :bind
  ([remap org-toggle-comment] . resize-window)
  :init
  (condition-case nil
      (require 'org-tempo)
    ((error) nil)))

(use-package ox-reveal
  :config
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))

(use-package htmlize)

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

(use-package selectrum
  :demand t
  :config
  (selectrum-mode +1))

(use-package selectrum-prescient
  :config
  (prescient-persist-mode 1)
  (selectrum-prescient-mode 1))

(use-package embark
  :bind
  ("C-c C-c" . embark-act-noexit))

(use-package consult
  :config
  (setq-default consult-project-root-function 'projectile-project-root)
  :bind
  ([remap switch-to-buffer] . 'consult-buffer)
  ([remap switch-to-buffer-other-window] . 'consult-buffer-other-window))

(use-package embark-consult)

(use-package marginalia
  :init
  (marginalia-mode)
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  (advice-add #'marginalia-cycle :after
              (lambda () (when (bound-and-true-p selectrum-mode) (selectrum-exhibit)))))

(defun personal/ag-at-point ()
  (interactive)
  (let ((current-word (thing-at-point 'symbol)))
    (counsel-ag current-word)))

(use-package ivy)

(use-package counsel
  :bind
  ("C-r" . personal/ag-at-point)
  ("C-s" . swiper))

(use-package paredit)

(use-package rainbow-delimiters)

(use-package magit
  :bind (("C-x g" . magit-status)
         :map
         magit-status-mode-map
         ("M-RET" . magit-diff-visit-file-other-window)
         ("C-RET" . magit-diff-visit-file-other-window)))

(use-package eldoc
  :diminish
  :hook
  (prog-mode . turn-on-eldoc-mode))

(use-package flycheck)

(defun standard-lisp-environment ()
  (paredit-mode 1)
  (rainbow-delimiters-mode 1)
  (eldoc-mode 1))

(defconst personal/my-lisps '(clojure lisp emacs-lisp cider-repl geiser
                                      geiser-repl scheme inf-clojure
                                      ;;racket slime repl
                                      ))

(hook-up-modes personal/my-lisps #'standard-lisp-environment)

(use-package vterm
  :config
  (defun turn-off-chrome ()
    (hl-line-mode -1)
    (display-line-numbers-mode -1))
  :ensure t
  :hook (vterm-mode . turn-off-chrome))

(bind-key "C-x m" 'eshell)
(bind-key "C-x M" (lambda () (interactive) (eshell t)))

(use-package fish-mode)

(use-package yasnippet
  :demand t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs (list "~/.emacs.d/snippets")))

(use-package parseedn)
(use-package pkg-info)
(use-package queue)
(use-package spinner)
(use-package seq)
(use-package sesman)
(use-package buttercup)

(use-package paredit
  :bind (:map
         paredit-mode-map
         ("C-j" . nil)
         ("{" . paredit-open-curly)))

(use-package flycheck-clj-kondo
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package clojure-mode
  :load-path "~/projects/dev/clojure-mode"
  :config
  (setq clojure-toplevel-inside-comment-form t)
  (setq clojure-indent-style 'align-arguments)
  (put-clojure-indent 'dofor 1)
  (put-clojure-indent 'do-at 1)
  (put-clojure-indent 'match 1)

  (put-clojure-indent 'context 1)
  (put-clojure-indent 'GET 1)
  (put-clojure-indent 'compojure/GET 1)
  (put-clojure-indent 'compojure/POST 1)
  (put-clojure-indent 'compojure/PATCH 1)
  (put-clojure-indent 'compojure/PUT 1)
  (put-clojure-indent 'compojure/DELETE 1)
  (put-clojure-indent 'POST 1)
  (put-clojure-indent 'PATCH 1)
  (put-clojure-indent 'DELETE 1))

;; testing dependency for inf-clojure
(use-package assess)

(defun personal/repl-requires ()
  "Send repl requires."
  (interactive)
  (when-let ((inf-proc (inf-clojure-proc 'no-error)))
    (inf-clojure--send-string inf-proc "(apply require clojure.main/repl-requires)")))

(defun inf-clojure-send-input ()
  "Send."
  (interactive)
  (let ((clojure-process (inf-clojure-proc)))
    (with-current-buffer (process-buffer clojure-process)
      (comint-goto-process-mark)
      (while (looking-at-p "\s*\n")
        (forward-line))
      (set-marker (process-mark clojure-process) (point))
      (comint-send-input t))))

(use-package inf-clojure
  :demand t
  :load-path "~/projects/dev/inf-clojure/"
  :bind (:map
         inf-clojure-mode-map
         ("RET" . newline)
         ("C-j" . inf-clojure-send-input)
         ("C-c h" . personal/repl-requires)
         :map
         inf-clojure-minor-mode-map
         ("C-c h" . personal/repl-requires)))

(use-package cider
  :demand t
  :load-path "~/projects/dev/cider/"
  :init
  (load "cider-autoloads" t t)
  :config
  (setq cider-invert-insert-eval-p t)
  (setq cider-switch-to-repl-on-insert nil)
  (setq cider-auto-select-test-report-buffer nil)
  (setq cider-font-lock-dynamically t)
  (setq cider-show-error-buffer nil)
  (setq cider-repl-display-help-banner nil)
  (setq cider-repl-pop-to-buffer-on-connect 'display-only)
  (setq cider-repl-tab-command (lambda () (company-indent-or-complete-common nil)))
  :bind (:map
         cider-repl-mode-map
         ("RET" . cider-repl-newline-and-indent)
         ("C-j" . cider-repl-return)
         ("C-c SPC" . clojure-align)
         ;; :map
         ;; paredit-mode-map
         ;; ("C-j" . cider-repl-return)
         ))

;; ‘C-x r s <register-key>’ save to register
;; 'C-c C-j x <register-key' to send to repl
(defun cider-insert-register-contents (register)
  (interactive (list (register-read-with-preview "From register")))
  (let ((form (get-register register)))
    ;; could put form into a buffer and check if its parens are
    ;; balanced
    (if form
        (cider-insert-in-repl form (not cider-invert-insert-eval-p))
      (user-error "No saved form in register"))))

(define-key 'cider-insert-commands-map (kbd "x") #'cider-insert-register-contents)
(define-key 'cider-insert-commands-map (kbd "C-x") #'cider-insert-register-contents)
(define-key cider-repl-mode-map (kbd "C-c C-j") 'cider-insert-commands-map)

(defun personal/unhook-cider ()
  (seq-doseq (buffer (buffer-list))
    (with-current-buffer buffer
      (cider-mode -1))
    (remove-hook 'clojure-mode-hook #'cider-mode)))

(use-package pos-tip)

(defun cider-tooltip-show ()
  (interactive)
  (if-let ((info (cider-var-info (thing-at-point 'symbol))))
      (nrepl-dbind-response info (doc arglists-str name ns)
        (pos-tip-show (format "%s : %s\n%s\n%s" ns (or name "") (or arglists-str "") (or doc ""))
                      nil
                      nil
                      nil
                      -1))
    (message "info not found")))

(bind-key "C-c t" 'cider-tooltip-show)

(use-package lsp-mode
  :ensure t
  :hook ((clojure-mode . lsp)
         (clojurec-mode . lsp)
         (clojurescript-mode . lsp))
  :config
  (setq lsp-enable-indentation nil)
  (setq lsp-enable-file-watchers nil) ;; annoying and i can't specify paths
  ;; add paths to your local installation of project mgmt tools, like lein
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
     (add-to-list 'lsp-language-id-configuration `(,m . "clojure"))))

(defun personal/stop-lsp ()
  (interactive)
  (remove-hook 'clojure-mode-hook #'lsp)
  (remove-hook 'clojurec-mode-hook #'lsp)
  (remove-hook 'clojurescript-mode-hook #'lsp))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :init
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-show-code-actions nil)
  :bind ("C-c C-d" . 'lsp-ui-doc-show)
  :commands lsp-ui-mode)

(use-package lsp-clojure-hydra
  :after (lsp-mode cider)
  :load-path "~/projects/elisp/lsp-clojure-hydra"
  :bind (("C-c C-l" . lsp-clojure-refactor-menu/body)
         :map
         cider-mode-map
         ("C-c C-l" . lsp-clojure-refactor-menu/body)
         :map
         inf-clojure-minor-mode-map
         ("C-c C-l" . lsp-clojure-refactor-menu/body)))

(use-package haskell-mode)

(use-package lsp-haskell
  :disabled t
  :after lsp-mode
  :hook (haskell-mode . lsp-haskell-enable))

(defun prolog-insert-prompt ()
  (interactive)
  (insert "\n%?- "))

(defun prolog-insert-comment-block ()
  "Insert a PceEmacs-style comment block like /* - - ... - - */ "
  (interactive)
  (let ((dashes "-"))
    (dotimes (_ 36) (setq dashes (concat "- " dashes)))
    (insert (format "/* %s\n\n%s */" dashes dashes))
    (forward-line -1)
    (indent-for-tab-command)))

(use-package prolog
  :after (ediprolog)
  :config
  (setq prolog-system 'swi
        prolog-program-switches '((swi ("-G128M" "-T128M" "-L128M" "-O"))
                                  (t nil))
        prolog-electric-if-then-else-flag t)
  :bind (:map prolog-mode-map
              ("C-c C-k" . ediprolog-dwim)
              ("C-c k" . ediprolog-dwim)
              ("C-;" . prolog-insert-comment-block)
              ("C-c j" . prolog-insert-prompt)
              ("C-c C-j" . prolog-insert-prompt)))

(use-package ediprolog)

(use-package geiser
  :bind (:map geiser-repl-mode-map
              ("C-j" . geiser-repl--maybe-send)
              ("RET" . indent-new-comment-line)
              ("C-a" . crux-move-beginning-of-line)
              ([return] . indent-new-comment-line)))

(use-package tuareg)

(use-package caml)

(use-package merlin
  :config
  (add-to-list 'exec-path "/Users/dan/.opam/4.11.0/bin/")
  (autoload 'merlin-mode "merlin" "Merlin mode" t)
  (add-hook 'tuareg-mode-hook 'merlin-mode)
  (add-hook 'caml-mode-hook 'merlin-mode))

(when (and personal/osx-p (boundp 'mac-auto-operator-composition-mode))
  (mac-auto-operator-composition-mode))

(use-package exec-path-from-shell
  :demand t
  :init
  (exec-path-from-shell-initialize))

(when personal/osx-p
  (setq mac-command-modifier 'meta))

(set-frame-font "Fira Code" nil t)
(defun personal/set-font ()
  (set-frame-font "Fira Code" nil t)
  (interactive)
  (set-face-attribute 'default nil :height (cond
                                            (personal/linux-machine 130)
                                            (personal/mac-machine 150)
                                            (t 140))))
(add-hook 'emacs-startup-hook #'personal/set-font)

(setq gc-cons-threshold personal/original-gc-threshold)
