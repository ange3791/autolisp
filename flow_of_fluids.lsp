(load "lib-general")

(setq pi 3.14159)


(defun velocity (flow diameter / ) ; ft/sec
	;flow gpm
	;diameter inches
	(* 0.4085 (/ flow (pow diameter 2))))


(defun kinematic_viscosity (dynamic_viscosity density / )
	; dynamic viscosity (cP)
	; density (lbm/cf)
	; convert cP to lbm/s-ft, lbm/s ft = 0.000672 * cP
	; kinematic_viscosity (ft^2 / s) = density * dynamic_viscosity
	; dynamic_viscosity = kinematic_viscosity / density
	(* density (* 0.000672 dynamic_viscosity)))

(defun Reynolds_number (vel diameter density dynamic_viscosity / ) ;Reynolds number
	; velocity (ft/sec)
	; diameter (inches)
	; dynamic viscosity (cP)
	; Re = density (lbm/cf) * velocity (ft/s) * diameter (ft) / dynamic_viscosity (lbm/s ft)
	; Re = velocity (ft/s) * diameter (ft) / kinematic_viscosity (ft^2/s)
	;convert cP to lbm/s-ft, lbm/s ft = 0.000672 * cP
	;(* vel diameter (/ 1.0 (kinematic_viscosity dynamic_viscosity density))))
	(* density vel (/ diameter 12.0) (/ 1.0 (* 0.000672 dynamic_viscosity))))


(defun friction_factor1 (Re roughness diameter / A B C) ;Serghide
	(if (< Re 2320)
		(/ 64 Re)
		(progn
			(setq
				A	(* (- 2.0) (log10 (+ (/ (* 12.0 roughness) (* diameter 3.7)) (/ 12.0 Re))))
				B	(* (- 2.0) (log10 (+ (/ (* 12 roughness) (* diameter 3.7)) (/ (* 2.51 A) Re))))
				C	(* (- 2.0) (log10 (+ (/ (* 12 roughness) (* diameter 3.7)) (/ (* 2.51 B) Re)))))
			(pow (- A (pow (- B A) 2.0) (+ C (- (* 2.0 B)) A)) (- 2.0)))))


(defun friction_factor (Re roughness diameter / A B C) ;Niazkar
	(if (< Re 2320)
		(/ 64 Re)
		(progn
			(setq
				A	(* (- 2.0) (log10 (+ (/ (* 12.0 roughness) (* diameter 3.7)) (/ 4.5547 (pow Re 0.8784)))))
				B	(* (- 2.0) (log10 (+ (/ (* 12 roughness) (* diameter 3.7)) (/ (* 2.51 A) Re))))
				C	(* (- 2.0) (log10 (+ (/ (* 12 roughness) (* diameter 3.7)) (/ (* 2.51 B) Re)))))
			(pow (- A (pow (- B A) 2.0) (+ C (- (* 2.0 B)) A)) (- 2.0)))))


(defun pd_h (flow diameter length density dynamic_viscosity / g roughness vel Kpipe)
	(setq 
		g 			32.2
		roughness 	0.00015
		vel 		(velocity flow diameter)
		Re 			(Reynolds_number vel diameter density dynamic_viscosity)
		ff 			(friction_factor Re roughness diameter)
		Kpipe 		(* ff length 12.0 (/ 1.0 diameter)))
	(* Kpipe (pow vel 2) (/ 1 (* 2.0 g))))
	;K = f * L/D
	;h = K * v^2/2g

;function friction_factor($Re, $roughness, $diameter) {
;
;    if ($Re < 2320) {
;        $fff = 64/$Re;
;    } else {
;        $A = -2 * log( (12*$roughness/($diameter*3.7)) + 12/$Re ,10);
;
;        $B = -2 * log( (12*$roughness/($diameter*3.7)) + (2.51 * $A)/$Re, 10);
;
;        $C = -2 * log( (12*$roughness/($diameter*3.7)) + (2.51 * $B)/$Re, 10);
;
;        $fff = pow( $A - (pow($B - $A,2) / ($C - 2*$B + $A)) ,-2);
;    }
;    return $fff;
;}


; water 
;	dynamic viscosity = 1cP (centipoise)
;	kinematic viscosity = 1 cSt (centistoke)

; dynamic_viscosity = kinematic_viscosity / density