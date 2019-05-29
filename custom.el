(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ad-redefinition-action (quote accept))
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(custom-safe-themes
   (quote
    ("8f97d5ec8a774485296e366fdde6ff5589cf9e319a584b845b6f7fa788c9fa9a" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "8e797edd9fa9afec181efbfeeebf96aeafbd11b69c4c85fa229bb5b9f7f7e66c" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" default)))
 '(indent-tabs-mode nil)
 '(kill-whole-line t)
 '(load-prefer-newer t)
 '(mouse-yank-at-point t)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (crux lsp-clojure lsp-mode hydra counsel ivy undo-tree all-the-icons rainbow-delimiters browse-kill-ring magit paredit sesman spinner queue parseedn flycheck-joker flycheck loccur moody minions resize-window company projectile neotree crosshairs smart-mode-line which-key visual-regexp-steroids pcre2el unfill auto-compile use-package)))
 '(read-buffer-completion-ignore-case t)
 '(read-file-name-completion-ignore-case t)
 '(safe-local-variable-values
   (quote
    ((cider-docker-translations
      ("/root/" . "/Users/dan/")
      ("/src/" . "/Users/dan/projects/"))
     (elisp-lint-indent-specs
      (if-let* . 2)
      (when-let* . 1)
      (let* . defun)
      (nrepl-dbind-response . 2)
      (cider-save-marker . 1)
      (cider-propertize-region . 1)
      (cider-map-repls . 1)
      (cider--jack-in . 1)
      (cider--make-result-overlay . 1)
      (insert-label . defun)
      (insert-align-label . defun)
      (insert-rect . defun)
      (cl-defun . 2)
      (with-parsed-tramp-file-name . 2)
      (thread-first . 1)
      (thread-last . 1))
     (checkdoc-package-keywords-flag))))
 '(show-trailing-whitespace t)
 '(uniquify-after-kill-buffer-p t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(uniquify-strip-common-suffix t)
 '(use-package-always-ensure t)
 '(use-package-verbose nil)
 '(vr/engine (quote pcre2el) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 16777215)) (:background "#282828" :foreground "#fdf4c1")) (((class color) (min-colors 255)) (:background "#262626" :foreground "#ffffaf")))))
