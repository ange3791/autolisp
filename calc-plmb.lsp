(load "lib-general")


(defun  c:calc-hwr ( / bn ents hwr-flow-total qdot-total deltaT)

  (setq bn "HWR")

  (setq deltaT 15.0)

  (setq ents (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 bn))

  (setq hwr-flow-total (sum (mapcar 'atoi (mapcar 'getattributevalue ents (mapcar '(lambda (z) "flow") ents)))))
  (setq qdot-total (sum (mapcar 'atoi (mapcar 'getattributevalue ents (mapcar '(lambda (z) "qdot") ents)))))
  
  ;;(princ (strcat "Total hwr flow (gpm): " (rtos hwr-flow-total 2 0) "\n"))
  (princ (strcat "Total hwr qdot (btu/hr): " (rtos qdot-total 2 0) "\n"))
 
  (princ (strcat "r at " (rtos deltaT 2 1) " degF delta T: " (rtos (/ qdot-total (* 500.0 deltaT)) 2 2) " gpm \n"))

  (princ))


(defun  c:calc-storm ( / bn ents)
  (setq iph 3) ;; once in 100 year max inches per hour
  (setq conv1 0.010389) ;; convert to gpm

  (setq bn "Logical_roof_drain")

  (setq ents (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 bn))

  (setq roof_area (sum (mapcar 'atoi (mapcar 'getattributevalue ents (mapcar '(lambda (z) "AREA") ents)))))
  

  (princ (strcat "Total Area (sqft): " (rtos roof_area 2 0) "\n"))
  (princ (strcat "100 year peak flow (gpm): " (rtos (* roof_area iph conv1) 2 0) "\n"))

  (princ))


(defun  c:calc-natgas ( / bn ents )
  (setq bn "Equipment_Plumbing")

  (setq ents (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 bn))

  (setq NatGas (sum (mapcar 'atoi (mapcar 'getattributevalue ents (mapcar '(lambda (z) "NATURAL_GAS_LOAD") ents)))))

  (princ (strcat "Natural Gas Load: " (rtos NatGas 2 0) " CFH" "\n"))

  (princ))


(defun  c:calc-FUs ( / bn ss ents x1 x2 x3)
  (setq bn "plmbX")

  (setq ents (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 bn))

  (setq CWFUs (sum (mapcar 'getattributevalue ents (mapcar '(lambda (z) "CWFUS") ents))))
  (setq HWFUs (sum (mapcar 'getattributevalue ents (mapcar '(lambda (z) "HWFUS") ents))))
  (setq TWFUs (sum (mapcar 'getattributevalue ents (mapcar '(lambda (z) "TWFUS") ents))))
  (setq DFUs (sum (mapcar 'getattributevalue ents (mapcar '(lambda (z) "DFUS") ents))))

  (princ (strcat "CWFUs: " (rtos CWFUs 2 0) "\n"))
  (princ (strcat "HWFUs: " (rtos HWFUs 2 0) "\n"))
  (princ (strcat "TWFUs: " (rtos TWFUs 2 0) "\n"))
  (princ (strcat "DFUs: " (rtos DFUs 2 0) "\n"))

  (princ))



