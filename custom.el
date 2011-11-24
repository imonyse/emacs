;; PATH
(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
  (push "/usr/local/bin" exec-path))

;; function that load third party library from vendor
(defun vendor (library)
  (let* ((file (symbol-name library))
         (normal (concat "~/.emacs.d/vendor/" file))
         (suffix (concat normal ".el")))
    (cond
     ((file-directory-p normal) 
      (add-to-list 'load-path normal)
      (require library))
     ((file-directory-p suffix) 
      (add-to-list 'load-path suffix)
      (require library))
     ((file-exists-p suffix) (require library)))))

;; custom functions
(defun jekyll-markdown-hook ()
  (define-skeleton jekyll-code-highlight
    "syntax highlight block for jekyll"
    "language:"
    "{% highlight "str" %}"\n
    _ \n
    "{% endhighlight %}")
  (define-key (current-local-map) (kbd "C-c h") 'jekyll-code-highlight)
  )
(add-hook 'markdown-mode-hook 'jekyll-markdown-hook)

(defun my-erb-mode-hook()
  (define-skeleton rails-erb-print
    "<%= %>"
    nil
    "<%= " _ " %>")
  (define-key (current-local-map) (kbd "C->") 'rails-erb-print)
  )
(add-hook 'rhtml-mode-hook 'my-erb-mode-hook)

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t))))
  (message "Refreshed open files.") )
(global-set-key (kbd "<f5>") 'revert-all-buffers)

;; theme
(load-theme 'tango-dark)

;; default fonts
(when window-system
  (set-default-font "Monaco-18")
  (set-fontset-font (frame-parameter nil 'font)
                    'han '("WenQuanYi Micro Hei Mono" . "unicode-bmp")))

;; rvm shortcuts
(global-set-key (kbd "<f6>") 'rvm-activate-corresponding-ruby)  
