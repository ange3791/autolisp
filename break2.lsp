(defun c:break2( / L1 P1)

   (setq x1 (getvar "OSMODE"))
   (setvar "OSMODE" 0)

   (Setq L1 (entsel "\nSelect line: "))
   (Setq P1 (getpoint "\nChoose point1: "))
   (command "_BREAK" L1 P1)
   (princ)
   (princ)

   (setvar "OSMODE" x1)
   (princ)
)


(defun C:br2 ()
  (c:break2)
)
