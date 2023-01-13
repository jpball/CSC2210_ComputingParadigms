;; Write three mathematical functions:
;; - square() squares a passed in parameter
;; - cube() cubes a passed in parameter
;; - pow() raises a base number to an exponent
;; For this group of functions do not use any built in mathematical functions.

(def square (fn [value]
    (
        * value value
    )))

(def cube (fn [value] 
    (
        * (* value value) value
    )))


;; Using reduce and repeat, find the power
(def pow (fn [base power] 
    (
        reduce * (repeat power base)
    )))

(println (square 5))
(println (cube 3))
(println (pow 2, 8))