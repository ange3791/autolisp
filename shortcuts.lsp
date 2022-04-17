(load "lib-general")

 

(defun  c:rc ( / arclength sc inp1)

	(setq inp1 (getreal "cloud size scale: "))
	(if (= inp1 nil)
		(setq sc 1)
		(setq sc inp1))

	(setq arclength (/ (* sc 24.0) (* (getvar "cannoscalevalue") 96.0)))
	;(princ (strcat "arc length: " (rtos arclength 2 1) " inches" "\n"))

	(command "_revcloud" "a" arclength arclength)
)


;;(defun  c:mla ( / )
;;
;;	(command "_aimleadereditadd" pause)
;;
;;)

;;(defun  c:mld ( / )
;;
;;	(command "_aimleadereditremove" pause)
;;
;;)


(defun  c:ml ( / )

	(command "_laymcur" pause)

)

(defun  c:lf ( / )

	(command "_layfrz" pause)

)
