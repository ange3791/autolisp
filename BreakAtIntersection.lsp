(defun c:BreakAtIntersection (/ pt1 pt1a bp1 bp2 bpnts ssAbove ssBelow BDis ctA ctB c1)

  (vl-load-com)


  (setq BDis (* 3 (/ (/ 1 (getvar 'cannoscalevalue)) 96)))



  ;select above
  (princ "Select lines above: \n")
  (setq ssAbove (ssget))

  ;select below
  (princ "Select lines below: \n")
  (setq ssBelow (ssget))

  (setq ctB 0)
  ;(while (< ctB (sslength ssBelow))
  (repeat (sslength ssBelow)
    ;get list of break points
    (setq objBelow (vlax-ename->vla-object (ssname ssBelow ctB)))

    (setq ctA 0)
    ;(while (< ctA (sslength ssAbove))
    (repeat (sslength ssAbove)
      (setq objAbove (vlax-ename->vla-object (ssname ssAbove ctA)))
      (setq intersections (vlax-invoke objAbove 'intersectWith objBelow acExtendNone))
      ;make list of break points
      (repeat (/ (length intersections) 3)
        ;(setq pt1 (list (car intersections) (cadr intersections) (caddr intersections)))
        (setq pt1 (take 3 intersections))
        (setq pt1a (vlax-curve-getdistatparam objBelow (vlax-curve-getparamatpoint objBelow pt1)))
        (setq bp1 (vlax-curve-getpointatdist objBelow (- pt1a BDis)))
        (setq bp2 (vlax-curve-getpointatdist objBelow (+ pt1a BDis)))

        (setq bpnts (cons bp1 bpnts))
        (setq bpnts (cons bp2 bpnts))

        ;chop down intersection list
        (setq intersections (drop 3 intersections))
      )
      (setq ctA (+ 1 ctA))
    )
    (setq ctB (+ 1 ctB))
  )

  (repeat (/ (length bpnts) 2)
    (command "._break" "_non" (trans (car bpnts) 0 1) "_non" (trans (cadr bpnts) 0 1))
    ;(command "._break" "f" (car bpnts) (cadr bpnts))
    (setq bpnts (cddr bpnts))
  )

  (princ)
)


(defun C:brr ()
  (c:BreakAtIntersection)
)
