(defun  c:BringAbove ()
  ;define the function
  (print "Select Over: ")
  (setq ssO (ssget))
  (prompt "Select Under: ")
  (setq ssU (ssget))
  (command "draworder" ssO "" "a" ssU "")
  (princ)
)

(defun C:ba ()
  (c:BringAbove)
)
