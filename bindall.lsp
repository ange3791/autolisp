(defun c:bindall()

	(command "-purge" "all" "*" "n")
	(setvar "bindtype" 1)

	(foreach x (mapcar 'cadr (ssnamex (ssget "_X" '((0 . "INSERT") (410 . "MODEL")))))
		(setq blk (cdr (assoc 2 (entget x))))
		(if (assoc 1 (tblsearch "block" blk))
			(progn
				(command "_.xref" "_bind" blk)
				;(command "explode" (entlast))
				))

	(command "-setbylayer" "all" "" "Y" "Y")
	(command "-purge" "all" "*" "n")
	(princ)
)
)
