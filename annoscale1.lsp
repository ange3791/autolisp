(defun c:ObjectScaleCurOnly (/ ss n scLst OSC:GetScales)
  (print "Select the objects you wish to modify: ")
  (if (or (setq ss (ssget "I")) (setq ss (ssget)))
    (progn
      ;; Define helper function to get scales attached to an entity
      (defun OSC:GetScales (en / ed xn xd cdn cdd asn asd cn cd sn sd cannoscale)
        (setq ed (entget en))
        (if (and
              ;; Get the XDictionary attached to the object
              (setq xn (vl-position '(102 . "{ACAD_XDICTIONARY") ed))
              (setq xn (cdr (nth (1+ xn) ed)))
              (setq xd (entget xn))
              ;; Get the Context Data Management dictionary attached to the XDictionary
              (setq cdn (vl-position '(3 . "AcDbContextDataManager") xd))
              (setq cdn (cdr (nth (1+ cdn) xd)))
              (setq cdd (entget cdn))
              ;; Get the Annotation Scales dictionary attached to the CD
              (setq asn (vl-position '(3 . "ACDB_ANNOTATIONSCALES") cdd))
              (setq asn (cdr (nth (1+ asn) cdd)))
              (setq asd (entget asn))
              ;; Get the 1st scale attached
              (setq cn (assoc 3 asd))
              (setq cn (member cn asd))
            )
          ;; Step through all scales attached
          (while cn
            (if (and (= (caar cn) 350) ;It it's pointing to a scale record
                     ;; Get the record's data
                     (setq cd (entget (cdar cn)))
                     ;; Get the Context data class
                     (setq sn (assoc 340 cd))
                     (setq sd (entget (cdr sn)))
                     (setq sn (assoc 300 sd))
                     ;; Check if the scale is already in the list
                     (not (vl-position (cdr sn) scLst))
                )
              ;; Add it to the list
              (setq scLst (cons (cdr sn) scLst))
            )
            (setq cn (cdr cn))
          )
        )
      )

      ;; Find a list of scales used in selection
      (setq n (sslength ss))
      (while (>= (setq n (1- n)) 0)
        (OSC:GetScales (ssname ss n))
      )

      ;; Add the current scale to the selection
      (setq cannoscale (getvar "CANNOSCALE"))
      (command "._ObjectScale" ss "" "_Add" cannoscale "")

      ;; Remove all other scales attached
      (command "._ObjectScale" ss "" "_Delete")
      (foreach n scLst
        (if (wcmatch (strcase n) (strcat "~" (strcase cannoscale)))
          (command n)
        )
      )
      (command "")
    )
  )

  (princ)
)
