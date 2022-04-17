(defun C:layall()

	(command ".layer" "unlock" "*" "")
	(command ".layer" "thaw" "*" "")
	(command ".layer" "on" "*" "")
	(command ".purge" "all" "*" "n")
	(princ "purged all")
	(princ)
)
