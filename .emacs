;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; My defuns ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun insert-dashes (how-many)
  "Inserts a line of HOW-MANY dashes and a blank line"
  (interactive "p")
  (if (null current-prefix-arg)
      (setq how-many 20))
  (let ((i 0))
    (while (< i how-many)
      (insert "-")
      (setq i (1+ i)))
    (insert "\n")
    (insert "\n")))

;;; Make it easy to reload a file if it's changed
;;; https://emacs.stackexchange.com/questions/169/how-do-i-reload-a-file-in-a-buffer
(defun revert-buffer-confirm-if-changed ()
    "Revert buffer (i.e. reload file) only prompting for confirmation if you've made changes in your buffer."
    (interactive)
    (revert-buffer t (not (buffer-modified-p)) t)
    (message "Reloaded from disk."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; The load path ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (setq load-path (append '("~/pers_env/emacs/lib") 
			  load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Key bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key "\^_" 'insert-dashes)
(global-set-key (kbd "\C-x \C-r") (lambda ()
				  (interactive)
				  (revert-buffer-confirm-if-changed)))
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Mode settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq fill-column 120)

(require 'yaml-mode)     ; https://github.com/yoshiki/yaml-mode
