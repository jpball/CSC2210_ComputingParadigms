;; Write a function that takes a number and will 
;; calculate the factorial value for that number.

;; 5! is 5 * 4 * 3 * 2 * 1 = 120

;; 10! is 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 = 3,628,800

;; Hint: this type of problem is typically done 
;; with recursion but there is a simple way to do it without.
;; Look at the range() and reduce() functions.

(defn factorial [num]
    (reduce * (range 1 (+ num 1)))
)

(println (factorial 10))
(println (factorial 5))