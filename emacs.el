(transient-mark-mode t)
(setq-default make-backup-files nil)
(setq inhibit-startup-message t)
(global-font-lock-mode t)
(setq x-select-enable-clipboard t)
(server-start)
(put 'set-goal-column 'disabled nil)
(setq truncate-partial-width-windows nil)
;; (setq ns-command-modifier 'meta)
(ns-toggle-toolbar nil)
(show-paren-mode 1)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key [(control return)] 'ns-toggle-fullscreen)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

(load "~/.emacs.d/custom.el")
(add-to-list 'load-path "~/.emacs.d/vendor")

;; yaml
(vendor 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; rinari
(vendor 'rinari)

;; rhtml-mode
(vendor 'rhtml-mode)
(add-hook 'rhtml-mode-hook
          (lambda () 
            (rinari-launch)
            (setq rhtml-indent-level 2)))

;; js.erb, javascript major mode, rinari as minor mode
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))

;; html
(add-hook 'html-mode-hook
          (lambda()
            (setq html-indent-level 2)))

;; RVM
(vendor 'rvm)
(rvm-use-default)
;; Ruby, Rake files are ruby, too, as are gemspecs, rackup files, etc.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
;; flymake for ruby
(add-hook 'ruby-mode-hook (lambda ()
                            (setq ruby-indent-level 2)
                            (vendor 'flymake-ruby)
                            (flymake-ruby-load)))

;; markdown
(vendor 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

;; textmate minor mode
(vendor 'textmate)
(textmate-mode)

;; CoffeeScript
(vendor 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cackefile" . coffee-mode))
(add-hook 'coffee-mode-hook
          '(lambda ()
             (set (make-local-variable 'tab-width) 2)
             (define-key coffee-mode-map (kbd "s-B") 'coffee-compile-buffer)
             (define-key coffee-mode-map (kbd "s-b") 'coffee-compile-region)
             (setq coffee-js-mode 'js-mode)
             ))

;; Git
(vendor 'magit)
(global-set-key (kbd "C-;") 'magit-status)

;; cucumber
(vendor 'feature-mode)
;; optional configurations
;; default language if .feature doesn't have "# language: fi"
(setq feature-default-language "ruby")
;; point to cucumber languages.yml or gherkin i18n.yml to use
;; exactly the same localization your cucumber uses
;;(setq feature-default-i18n-file "/path/to/gherkin/gem/i18n.yml")
;; and load feature-mode
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; SCSS 
(vendor 'scss-mode)
;; Rainbow, display text color on the background
(vendor 'rainbow-mode)
(add-hook 'scss-mode-hook 
          '(lambda ()
             (setq scss-compile-at-save nil)
             (rainbow-mode)))

;; CSS
(add-hook 'css-mode-hook
          '(lambda ()
             (setq css-mode-indent-depth 2)
             (make-local-variable 'indent-line-function)
             (setq indent-line-function 'css-indent)
             (define-key css-mode-map "\C-ct" 'css-insert-section)))

(defun css-indent ()
  (interactive)
  (insert "  "))

(defun css-insert-section (section)
  "Inserts a kyle-style css section."
  (interactive "sSection: ")
  (insert "/*--------------------------------------------------------------------\n")
  (insert (concat "  @group " section "\n"))
  (insert "--------------------------------------------------------------------*/\n")
  (insert "\n")
  (insert "\n")
  (insert "\n")
  (insert "/* @end */")
  (forward-line -2))

;; auto-complete
(vendor 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-config/ac-dict")
(ac-config-default)

;; javascript 
(add-hook 'js-mode-hook 
          '(lambda ()
             (vendor 'flymake-jslint)
             ;; (flymake-jslint-load)
             (setq js-indent-level 2)))
(put 'upcase-region 'disabled nil)

;; emacs lisp 
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil
                   tab-width        4
                   c-basic-offset   4)))

;; auto complete parentheses
(vendor 'autopair)
(autopair-global-mode)
