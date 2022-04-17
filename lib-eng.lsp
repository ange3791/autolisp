
(defun hw_ratio (T_cold T_hot T_mixed / )
  (/ (- T_mixed T_cold) (- T_hot T_cold)))


(defun cw_ratio (T_cold T_hot T_mixed / )
	(cond 	((<= T_mixed T_cold) 1)
			((>= T_mixed T_hot) 0)
			(T (/ (float (- T_hot T_mixed)) (- T_hot T_cold)))))


(defun hw_ratio (T_cold T_hot T_mixed / )
	(cond 	((<= T_mixed T_cold) 0)
			((>= T_mixed T_hot) 1)
			(T (/ (float (- T_mixed T_cold)) (- T_hot T_cold)))))


(defun dP-Cv (Q Cv / )
	(pow (/ (+ Q 0.0) Cv) 2))