(setq flymake-err-line-patterns 
      (cons '("^  [[:digit:]]+ \\([[:digit:]]+\\),\\([[:digit:]]+\\): \\(.+\\)$"  
	      nil 1 2 3)
	    flymake-err-line-patterns))

(defvar flymake-jslint-allowed-file-name-masks '(("\\.json$" flymake-jslint-init)
						 ("\\.js$" flymake-jslint-init)))

(defun flymake-jslint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "jslint" (list local-file))))

(defun flymake-jslint-load ()
  (interactive)
  (unless (eq buffer-file-name nil)
    (set (make-local-variable 'flymake-allowed-file-name-masks) flymake-jslint-allowed-file-name-masks)
    (flymake-mode t)))

(provide 'flymake-jslint)
