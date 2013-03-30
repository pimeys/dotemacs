(require 'package)

;Packages
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(setq url-http-attempt-keepalives nil)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp")

;mo-git-blame
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

;Evil mode setup
(evil-mode 1)
(require 'evil-leader)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'find-tag
  "f" 'helm-projectile
  "a" 'projectile-ack
  "bl" 'buffer-menu
  "bk" 'ido-kill-buffer
  "b," 'previous-buffer
  "b." 'next-buffer
  "c"  'flash-crosshairs
  "rr" 'rinari-launch
  "rc" 'rinari-find-controller
  "rm" 'rinari-find-model
  "rh" 'rinari-find-helper
  "rt" 'rinari-find-test
  "rs" 'rinari-find-rspec
  "gg" 'git-gutter:toggle
  "gd" 'git-gutter:popup-diff
  "gp" 'git-gutter:previous-hunk
  "gn" 'git-gutter:next-hunk
  "gr" 'git-gutter:revert-hunk
  "gb" 'mo-git-blame-current
  "gl" 'magit-log
  "gs" 'magit-status)

;Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(inhibit-startup-screen t))

(make-directory "~/.emacs.d/autosaves/" t)

(defalias 'yes-or-no-p 'y-or-n-p)

;Hooks

(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation))))

(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s")
  'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

;Look&Feel

(set-default-font "Inconsolata-13")
(load-theme 'solarized-dark)

;Modes

(electric-indent-mode +1)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(powerline-default)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
(tooltip-mode -1)
(crosshairs-mode -1)

(fringe-mode 'left-only)
(global-git-gutter-mode t)
(setq git-gutter:always-show-gutter t)
(setq git-gutter-fr:side 'left-fringe)
(setq global-linum-mode -1)

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-compilation-system 'default)
(highlight-indentation-mode)
(require 'auto-complete-config)
(ac-config-default)

(setq inhibit-startup-message t) ;; No splash screen
(setq initial-scratch-message nil) ;; No scratch message
;; Create backup files in .emacs-backup instead of everywhere
(defvar user-temporary-file-directory "~/.emacs-backup")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(setq inhibit-startup-message t)

(setq rinari-tags-file-name "tags")

(require 'surround)
(global-surround-mode 1)

;Key config

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)
(define-key evil-normal-state-map (kbd "C-o") 'previous-buffer)
(define-key evil-normal-state-map (kbd "C-p") 'next-buffer)
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)

(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))
