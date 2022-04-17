
(defun pow (a b / )
  (expt a b))

(defun logb (b x / )
  (/ (log x) (log b)))

(defun log10 (x / )
  (logb 10 x))



(defun roundup (x / n)
  (if (or (= (setq n (fix x)) x) (< x 0))
    n
    (1+ n)
  )
)


(defun qsort (L)
  (if (null L)
    nil
    (append
      (qsort (list< (car L) (cdr L)))
      (cons (car L) nil)
      (qsort (list>= (car L) (cdr L))))))


(defun list< (N L)
; Makes a copy of list L containing only elements that are < N. L must be a list of numbers.
  (if (null L)
    nil
    (if (< (car L) N)
      (cons (car L)
      (list< N (cdr L))
      )
    (list< N (cdr L)))))


(defun list>= (N L)
; Makes a copy of list L containing only elements that are < N. L must be a list of numbers.
  (if (null L)
    nil
    (if (>= (car L) N)
      (cons (car L)
      (list>= N (cdr L))
      )
    (list>= N (cdr L)))))


(defun lsort (list0 / min0 pos0 oldlist newlist) 
  ;dumb number list sort
  (setq 
    oldlist list0
    newlist (list))
  (while (> (length oldlist) 0)
    (setq 
      min0 (apply 'min oldlist)
      pos0 (vl-position min0 oldlist)
      newlist (cons min0 newlist)
      oldlist (LM:RemoveNth pos0 oldlist)))

  (reverse newlist))


(defun LM:RemoveNth ( n l / i )
    (setq i -1)
    (vl-remove-if '(lambda ( x ) (= (setq i (1+ i)) n)) l)
)


(defun range (a b / k list0)
  (setq k a)
  (setq list0 (list))
  (while (<= k b)
    (setq list0 (cons k list0))
    (setq k (1+ k))) (reverse list0))


(defun sum (list1 / x)
  (apply '+ (mapcar '(lambda (x) (if (= 'STR x) (atof x) x)) list1))
)

;(if (= 'STR x) (atof x) x)

;;(defun entdefdata_filter (list1 group_code val / )
;;  (vl-remove-if-not '(lambda (x) (= val (cdr (assoc group_code x)))) list1))

(defun entdefdata_filter (ents group_code val / )
  ;;filter list of entities on group code value
  (vl-remove-if-not '(lambda (x) (= val (cdr (assoc group_code (entget x))))) ents))


(defun ss2entities (ss / e i s x a)
  ;;convert selection set to list of entities
  (setq i 0)
  (repeat (sslength ss)
    (setq e (ssname ss i))
    (setq i (1+ i))
    (setq a (cons e a))))


  (defun getattributevalue ( blk tag / val enx tag)
      ;;get attribute valve from block
      (while
          (and
              (null val)
              (setq blk (entnext blk))
              (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk)))))
          )
          (if (= (strcase tag) (strcase (cdr (assoc 2 enx))))
              (setq val (cdr (assoc 1 (reverse enx))))
          )
      )
  )


(defun fnc:getattributevalue ( att ent_list / z ) 
	(mapcar 'getattributevalue ent_list (mapcar '(lambda (z) att) ent_list)))


(defun keyval ( key0 list0 / vp)
  (setq vp (vl-position key0 list0))
  (if (= vp nil)
    nil
	 (nth (+ 1 (vl-position key0 list0)) list0)))



(defun rand (/ modulus multiplier increment random)

  (if (not seed)
   (setq seed (getvar "DATE"))
  )

  (setq modulus    65536
        multiplier 25173
        increment  13849
        seed  (rem (+ (* multiplier seed) increment) modulus)
        random     (/ seed modulus)
  )

)


(defun percentile (p l / n)
  (setq n (1- (fix (* p (length l)))))
  (nth n (qsort l)))

;; Count Items  -  Lee Mac
;; Returns a list of dotted pairs detailing the number of occurrences of each item in a supplied list.
(defun LM:CountItems ( l / c l r x )
    (while l
        (setq x (car l)
              c (length l)
              l (vl-remove x (cdr l))
              r (cons (cons x (- c (length l))) r)
        )
    )
    (reverse r)
)



(defun ss_entities_since ( entX / ss )
  (setq ss (ssadd))
    (while (setq entX (entnext entX))
      (ssadd entX ss))
    ss)


(defun vla-collection->enames ( col / list1 )
  ;convert collection of vla objects to list of entities
  (setq list1 '())
  (vlax-for obj col
    (setq list1 (cons (vlax-vla-object->ename obj) list1))))


(defun vla-collection->list ( col / list1 )
  ;convert collection of vla objects to list of objects
  (setq list1 '())
  (vlax-for obj col
    (setq list1 (cons obj list1))))


(defun LM:sublst ( lst idx len / rtn )
  ;; Sublst  -  Lee Mac
  ;; The list analog of the substr function
  ;; lst - [lst] List from which sublist is to be returned
  ;; idx - [int] Zero-based index at which to start the sublist
  ;; len - [int] Length of the sublist or nil to return all items following idx

    (setq len (if len (min len (- (length lst) idx)) (- (length lst) idx))
          idx (+  idx len)
    )
    (repeat len (setq rtn (cons (nth (setq idx (1- idx)) lst) rtn)))
)


(defun take (n lst / )
  (LM:sublst lst 0 n))

(defun drop (n lst / )
  (LM:sublst lst n nil))


(defun file->list ( fname / f lst0 )
  (setq f (open fname "r"))
  (setq lst0 '())
  
  ;read file contents into list
  (while (setq line (read-line f))   
    (setq lst0 (cons line lst0)))
  (close f)

  ;process list
  (reverse (vl-remove-if '(lambda (x) (= x "")) lst0)))


(defun reduce (lst0 func / c a i)
  (setq i 0)
  (setq c nil)

  (repeat (length lst0)
    (setq a (nth i lst0))
    (if (= i 0)
      (setq c (func (if (= (type a) 'STR) "" 0) (nth i lst0)))
      (setq c (func c (nth i lst0))))
    (setq i (+ i 1)))
  c)


(defun get-int (msg default / inp1)
  (setq inp1 (getint msg))
  (if (= inp1 nil) default inp1))


(defun LM:setattributevalue ( blk tag val )
    (setq tag (strcase tag))
    (vl-some
       '(lambda ( att )
            (if (= tag (strcase (vla-get-tagstring att)))
                (progn (vla-put-textstring att val) val)
            )
        )
        (vlax-invoke (vlax-ename->vla-object blk) 'getattributes)
    )
)



(defun change-block-att ( blk-name att-tag att-value-old att-value-new / ents1 )

  ;;(setq ents1 (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 blk-name))
  (setq ents1 (vl-remove-if-not '(lambda (x) (= att-value-old (getattributevalue x att-tag))) (entdefdata_filter (ss2entities (ssget '((0 . "INSERT") ))) 2 blk-name)))

  
  (mapcar '(lambda (x) (LM:setattributevalue x att-tag att-value-new)) ents1)
  (length ents1)
)


;(while (> (getvar 'cmdactive) 0)
        ;(command pause))


;;If your application requires the name of the last nondeleted entity (main entity or subentity), define a function such as the following and call it instead of entlast.
;
;(defun lastent (/ a b) 
;  (if (setq a (entlast))         Gets last main entity
;    (while (setq b (entnext a))  If subentities follow, loopsuntil there are no more 
;      (setq a b)                 subentities 
;    ) 
;  ) 
;  a                              Returns last main entity 
;)                                or subentity