(load "lib-general")

 
(defun  c:CR ( /  ss0 ssX pt1 pt2 last_ent)

	(setq ss0 (ssget))
	(setq pt1 (getpoint "Basepoint:"))
	(princ "\n")
	;(setq pt2 (getpoint "Paste To: "))
	;(princ (strcat "selected: " (itoa (sslength ss0)) "\n"))
	
	(while t
		;get name of last entity added to drawing
		(setq last_ent (entlast))
		;(princ last_ent)

		(command-s "copy" ss0 "" pt1 pause)
		;get all entities just pasted
		(setq ssX (ss_entities_since last_ent))
  		
  		;rotate pasted entities
  		(command "_rotate" ssX "" (getvar 'lastpoint) pause)
		;(command "_rotate" (ss_entities_since (entnext last_ent)) "" (getvar 'lastpoint) pause)

	)
	 
  	(princ)
)