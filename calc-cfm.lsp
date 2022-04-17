(load "lib-general")

(defun  c:calc-cfm ( / bn ss ents x1 x2 x3)
  (setq bn "AD_DATA")

  (setq ents (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 bn))
  
 	(setq cfm_supply (sum (mapcar 'atoi (mapcar 'getattributevalue ents (mapcar '(lambda (z) "CFM")  (vl-remove-if-not '(lambda (x) (= "S"  (substr (getattributevalue x "AIR_DEVICE_TYPE") 4 1)  ))  ents))))))
 	(setq cfm_return (sum (mapcar 'atoi (mapcar 'getattributevalue ents (mapcar '(lambda (z) "CFM")  (vl-remove-if-not '(lambda (x) (= "R"  (substr (getattributevalue x "AIR_DEVICE_TYPE") 4 1)  ))  ents))))))
 	(setq cfm_exhaust (sum (mapcar 'atoi (mapcar 'getattributevalue ents (mapcar '(lambda (z) "CFM")  (vl-remove-if-not '(lambda (x) (= "E"  (substr (getattributevalue x "AIR_DEVICE_TYPE") 4 1)  ))  ents))))))

  (princ (strcat "Supply (CFM): " (rtos cfm_supply 2 0) "\n"))
  (princ (strcat "Return (CFM): " (rtos cfm_return 2 0) "\n"))
  (princ (strcat "Exhaust (CFM): " (rtos cfm_exhaust 2 0) "\n"))

  (princ))