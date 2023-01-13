;; Write a function called range-inclusive() that takes a starting 
; and ending integer value.

;; Create and return a range from the starting 
; value up to and including the ending value. 

;; You can use Clojure's built in range() function.
;; If the starting value is greater than the ending value then swap them and create the range.

;; Write some code to test the function by calling it with different values.

(defn range-inclusive [start, end]

    (if (<= start end)
        (range start (+ 1 end))
        (range end (+ 1 start)
    ))
)

(println (range-inclusive 0 10  ))
(println (range-inclusive 2 20  ))
