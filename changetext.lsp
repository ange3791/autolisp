(load "lib-general")

 

(defun  c:cht ( /  ss0 ent_name1 ent_data1 )

	(princ "select text: \n")
	(setq ss0 (ssget  '( (0 . "TEXT,MTEXT,MULTILEADER") )))
	(setq new_text (getstring 1 "New text: "))
	(princ)

	(mapcar '(lambda (x) (chtxt x new_text)) (ss2entities ss0))

	(princ)

)


(defun chtxt ( ent_name txt / ent_data ent_type_code) 
	(setq ent_data (entget ent_name))
	(setq ent_type_code (if (= (cdr (assoc 0 ent_data)) "MULTILEADER") 304 1))
	(setq ent_data (subst (cons ent_type_code txt) (assoc ent_type_code ent_data) ent_data))
	(entmod ent_data))