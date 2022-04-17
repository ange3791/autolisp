(load "lib-general")

(defun  c:calc-invert ( / slope-rise slope rise run pt0 pt inv-start)
  
  (setq slope-rise (get-real "\nslope (inches per foot): " 0.125))

  (setq slope (/ slope-rise 12.0))

  (setq inv-start (get-real "\nStarting invert (feet): " 0.0))


  (setq run 0)
  (setq pt0 (getpoint "pick start point: "))
  
  ;get run from user input
  (while

    (setq pt (getpoint "pick next point: "))
    (if (/= pt nil)
      (progn
        (setq run (+ run (distance pt0 pt)))
        (setq pt0 pt))))

  (setq rise (* slope run))

  (princ (strcat "Run: " (rtos (/ run 12) 2 2) "ft\n"))

  (princ (strcat "Rise: " (rtos rise 2 2) "in (" (rtos (/ rise 12) 2 2) "ft)\n"))

  (princ (strcat "Ending Inver: " (rtos (+ inv-start (/ rise 12)) 2 2) " ft\n"))

  (princ))

(defun get-real (msg x / inp1)
  (setq inp1 (getreal msg))
  (if (= inp1 nil) x inp1))
