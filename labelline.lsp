(defun c:labelline (/ sel1 entname1 p1 obj1 a1 layer1 objLayers objLayer acadDocument label1 p_start p_end)

  (vl-load-com)
  (setq acadDocument (vla-get-activedocument (vlax-get-acad-object)))

  (while

    ;(prompt "Select lines to label: ")
    (setq sel1 (entsel))
    (setq entname1 (car sel1))

    ;get line and text base point
    ;(setq p1 (osnap (cadr sel1) "midpoint"))
    (setq p1 (osnap (cadr sel1) "nearest"))
    ;(command "line" p1 '(0 0 0) "")
    ;
	(setq 
		layer1 	(cdr (assoc 8 (entget entname1)))
		a0 		(angle (cdr (assoc 10 (entget entname1))) (cdr (assoc 11 (entget entname1)))))

 	;(setq obj1 (vlax-ename->vla-object entname1))
    ;(setq a1 (+ 0 (vlax-get-property obj1 'Angle)))
    ;(setq a0 (vlax-get-property obj1 'Angle))

    ;rotate text 180 if needed
    (if 
      (AND (>= a0 1.570795) (<= a0 4.712385)) 
      (setq a1 (+ a0 3.14159))
      (setq a1 a0)
    )
      
    ;label text
    ;(setq layer1 (cdr (assoc 8 (entget entname1))))


    (setq objLayers (vla-get-layers acadDocument))
    (setq objLayer (vla-item objLayers layer1))
    ;(vlax-dump-object objLayer)
    ;(setq label1 (cdr (assoc 6 (tblsearch "LAYER" layer1))))
    (setq label1 (vla-get-description objLayer))

    (setq drawingscale (getvar "cannoscalevalue"))
    (setq paperheight 0.07)
    (setq modelheight (/ paperheight drawingscale))

    (entmake (list
    	     (cons 0 "MTEXT") ;entity type
    	     (cons 100 "AcDbEntity")
    	     (cons 100 "AcDbMText")
    	     (cons 7 "STANDARD") ;text style name
    	     (cons 71 5) ;justify 5=middle centerst
    	     (cons 10 p1) ;Insertion point
    	     (cons 50 a1) ;rotation
    	     (cons 40 modelheight) ;nominal text height, current annotative scale?
           (cons 46 paperheight) ;defined annotative height
    	     (cons 1 label1) ;text string
           (cons 8 layer1) ;layer name
           (cons 45 1.1) ;background mask offset factor
           (cons 90 3) ; background fill 0=background fill off, 1=use background fill color, 3=use drawing window color
           ;(cons 63 256) ;background fill color optional, color to use for background fill when group code 90=1
           ;(cons 441 0) ;transparency of background fill color (not implemented)
    	     ;(cons 72 5) ;drawing direction 1=left to right, 3=top to bottom, 5=by style
    	     ;(cons 73 1) ;mtext line spacing style (optional) 1=at least, 2=exact
           ;(cons 11 (list 1.0 0.0 0.0)) ;?
           ;(cons 41 1) ; reference rectangle width
           ;(cons 44 1.0) ;column spacing OR mtext line spacing factor
           (cons 67 0) ;???
    	   )
      )
      ;(command "_change" (entlast) "" "P" "Anno" "Y" "")
  )

  (princ)
)

(defun C:LL ()
  (c:labelline)
)
