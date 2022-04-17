(load "lib-general")


(defun  c:plotting ( / )
  (princ)

  )

(defun paper-size ( / active-layout )
  (vl-load-com)

  (setq active-layout (vla-get-ActiveLayout (vla-get-activedocument (vlax-get-acad-object))))
  (vlax-get-property active-layout 'CanonicalMediaName))


(defun set-to-48x36 ( / active-layout )
  (vlax-put-property active-layout 'CanonicalMediaName "UserDefinedImperial (48.00 x 36.00Inches)")
  (vlax-put-property active-layout 'PlotRotation 0))


;(vlax-get-property active-layout 'PlotRotation)
