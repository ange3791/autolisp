(vl-load-com)
(load "lib-general")


(defun  lx ( lctl lname / )
	;(princ (vl-symbol-name lctl))
	;(setq lctl (getstring "layer control: "))
	;(setq lname (getstring "layername string: "))
	;(command "-layer" lctl (strcat "*" lname "*") "")
	(command "-layer" lctl lname "")

	(princ))


(defun rev-layers ( n / all-layers rev-layers)


	(setq layer-prefix "R-")
	;;get all layers
	;vanilla
	;(setq all-layers (vla-collection->enames (vla-get-Layers (vla-get-ActiveDocument (vlax-get-acad-object)))))

	;vla objects
	(setq all-layers (vla-collection->list (vla-get-Layers (vla-get-ActiveDocument (vlax-get-acad-object)))))


	;get list of rev layers and sort
	;vanilla
	;(setq rev-layers (vl-remove-if-not '(lambda (x) (= layer-prefix (substr (cdr (assoc 2 (entget x))) 1 (strlen layer-prefix)) )) all-layers))
	;(setq l2-sorted (vl-sort l2 '(lambda (A B) (> (cdr (assoc 2 (entget A))) (cdr (assoc 2 (entget B)))))))

	;vla
	(setq rev-layers (vl-remove-if-not '(lambda (x) (= layer-prefix (substr (vlax-get-property x "Name") 1 (strlen layer-prefix)) )) all-layers))
	(setq rev-layers-sorted (vl-sort rev-layers '(lambda (A B) (> (vlax-get-property A "Name") (vlax-get-property B "Name") ))))
	

	(setvar 'clayer "0")
	(cond 
		((= n 0)
			;freeze all rev layers
			(progn
				(princ "Freezing all Rev layers...\n")
				(mapcar '(lambda (x) (vlax-put-property x "Freeze" 1)) rev-layers-sorted)))

		((= n 1)
			;freeze all but last rev layer
			(progn
				(princ "Freezing all but last Rev layers...\n")
				(vlax-put-property (car rev-layers-sorted) "Freeze" 0)
				(mapcar '(lambda (x) (vlax-put-property x "Freeze" 1)) (cdr rev-layers-sorted))))
		(t nil))


		(command "regen")



	;;thaw last rev layer
	;(vlax-put-property (car rev-layers-sorted) "Freeze" 0)
	
	;;freeze rest of rev layers
	;(mapcar '(lambda (x) (vlax-put-property x "Freeze" 1)) (cdr rev-layers-sorted))

	
	(princ))


(defun flt ( fname / lst1 str1 f)
	;freeze-layers-txt
	;(setq fname (getstring "file name: "))
	
	(setq lst1 (file->list (strcat (getvar "dwgprefix") fname)))
	
	(command "_layer" "_freeze" (reduce lst1 (lambda (a b) (strcat a "*" b "*,"))) "")
)
