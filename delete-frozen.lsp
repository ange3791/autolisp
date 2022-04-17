(defun Layers1 (parameter value / d r)
	(while (setq d (tblnext "LAYER" (null d)))
		(if (equal value (cdr (assoc parameter d)))
				(setq r (cons (cdr (assoc 2 d)) r))))
	r
)


(defun C:delete-frozen ( / layers cmd1)

		(command "-purge" "all" "*" "n")
		(setq layers (Layers1 70 1))

		(setq cmd1 '())
		(foreach l layers
			(setq cmd1 (cons l cmd1))
			(setq cmd1 (cons "n" cmd1))
		)
		;(setq cmd11 (list "n" "4" "n" "5"))
		;(setq cmd0 (append '(command "_.laydel") cmd1 '("" "y")))
		'(princ cmd1)

		(eval (append '(command "_.laydel") cmd1 '("" "y")))
		'(eval cmd0)

		(command "-overkill" "all" "" "")
		(command "-purge" "all" "*" "n")
		(princ)
)




;(setq layerlist nil)
;(while
;	(setq d (tblnext "layer" (null d))) ;;;loop thru layer table
;		(if (and (setq lname (strcase (cdr (assoc 2 d)))) ;;;get layer name
;	 		(= (cdr (assoc 70 d)) 0) ;;;layer not frozen (> (cdr (assoc 62 d)) 0) ;;;layer not off (wcmatch lname "~*|*" ) ;;;not an xref layer )
;	 	(setq layerlist (cons lname layerlist)) )
;
;
;
;)
