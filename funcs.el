;; Custom functions
(defun insert-buffer-name ()
  "Insert the buffer name without it's suffix."
  (insert (car (split-string (buffer-name) "\\."))))

(defun replace-import-with-require ()
  "Replace js imports with require."
  (interactive)
  (search-forward "import")
  (delete-char -6)
  (delete-char 1)
  (insert "const { ")
  (search-forward "from")
  (delete-char -4)
  (insert "} = require(")
  (delete-char 1)
  (end-of-line)
  (delete-char -1)
  (insert ");"))

(defun convert-export-to-module-exports ()
  "Convert es6 default export to module.exports."
  (interactive)
  (search-forward "export default")
  (delete-char -14)
  (insert "module.exports.")
  (insert-buffer-name)
  (insert " ="))

(defun ramda-count ()
  "Count how many ramda calls we still have from a git grep."
  (interactive)
  (push-mark)
  (while (search-forward "R." nil t)
    (backward-char 2)
    (kill-region (region-beginning) (region-end))
    (forward-word 2)
    (insert "\n")
    (push-mark))
  (kill-line)
)
