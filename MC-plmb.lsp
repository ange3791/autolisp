(load "lib-general")
(load "lib-eng")

(load "MC-data")



(defun  c:MC-plmb ( / ents N flows_N cw_N hw_N w_N T_cold T_hot)
	
	(setq 	N 		(get-int "Number of trials: " 100)
			T_cold 	50
			T_hot 	140)

	;(setq N 1200)
	
	(setq ents (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 "MC-plmb-fixture"))

	(print)

	

	(setq 	flows_N 	(mapcar '(lambda (x) (flows ents fixture_types "MC-WTR")) (range 1 N))
			cw_N		(mapcar '(lambda (x) (nth 0 x)) flows_N)
			hw_N		(mapcar '(lambda (x) (nth 1 x)) flows_N)
			w_N			(mapcar '(lambda (x) (+ (nth 0 x) (nth 1 x))) flows_N))
	
	(princ (strcat "CW peak: " (rtos (percentile 0.99 cw_N) 2 0) " gpm \n" ))
	(princ (strcat "HW peak: " (rtos  (percentile 0.99 hw_N) 2 0) " gpm \n" ))
	(princ (strcat "CW+HW peak: " (rtos (percentile 0.99 w_N) 2 0) " gpm \n" ))
	(setq 
		hw_gph (* 60 (/ (sum hw_N) (length hw_N)))
		wh_mbh (* hw_gph 8.33 (- T_hot T_cold) 0.001)
		wh_kw (/ wh_mbh 3.412))
		
	(princ (strcat "Average HW demand: " (rtos hw_gph 2 0) " gph -> " (rtos wh_mbh 2 0) "mbh = " (rtos wh_kw 2 0) "kW\n" ))
	(princ (strcat "Average CW+HW demand: " (rtos (* 60 (/ (sum w_N) (length w_N))) 2 0) " gph \n" ))
	
	(princ (strcat "CWFUs: " (rtos (sum (mapcar '(lambda (blk) (keyval ':CW (keyval 'FUs (keyval (read (getattributevalue blk "TYPE")) fixture_types)))) ents)) 2 0) "\n" ))
	(princ (strcat "HWFUs: " (rtos (sum (mapcar '(lambda (blk) (keyval ':HW (keyval 'FUs (keyval (read (getattributevalue blk "TYPE")) fixture_types)))) ents)) 2 0) "\n" ))
	(princ (strcat "WFUs: " (rtos (sum (mapcar '(lambda (blk) (keyval ':W (keyval 'FUs (keyval (read (getattributevalue blk "TYPE")) fixture_types)))) ents)) 2 0) "\n" ))
	(princ (strcat "DFUs: " (rtos (sum (mapcar '(lambda (blk) (keyval ':D (keyval 'FUs (keyval (read (getattributevalue blk "TYPE")) fixture_types)))) ents)) 2 0) "\n" ))

  	(princ "Fixture count: ")
  	(princ (LM:CountItems (mapcar '(lambda (blk) (getattributevalue blk "TYPE")) ents)))
  	(textscr)
  	(princ)

  	)



(defun flows (ents fixture_types system / f cw hw)

	(setq f (mapcar '(lambda (blk / p fixture_data)
			(setq fixture_data (keyval (read system) (keyval (read (getattributevalue blk "TYPE")) fixture_types)))

		;;(princ (strcat "use factor: " (rtos (if (numberp (keyval ':use_factor fixture_data)) (keyval ':use_factor fixture_data) 1) 2 2) "\n") )
		;;(princ (strcat "use factor: "  "\n"))

			;; fixture on probability
			(setq p (/ (/ (* (* (keyval ':use_factor fixture_data) (keyval ':gal_per_cycle fixture_data)) (keyval ':cycles_per_hour fixture_data)) (keyval ':flowrate_gpm fixture_data)) 60))
			(if (> p (rand))
				;;fixture flow rate if on
				(list (* (keyval ':flowrate_gpm fixture_data) (cw_ratio T_cold T_hot (keyval ':temperature fixture_data))) (* (keyval ':flowrate_gpm fixture_data) (- 1 (cw_ratio T_cold T_hot (keyval ':temperature fixture_data))))) 
				(list 0 0))
			) ents)
		 cw (sum (mapcar '(lambda (x) (car x)) f))
		 hw (sum (mapcar '(lambda (x) (cadr x)) f))
	)
	(list cw hw)
)