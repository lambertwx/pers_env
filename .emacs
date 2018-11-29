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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; The load path ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Key bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key "\^_" 'insert-dashes)
