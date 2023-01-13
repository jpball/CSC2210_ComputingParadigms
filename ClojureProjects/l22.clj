;; Write a function that takes one or more string parameters, 
;; converts them to numbers, and then adds them together and returns the sum.
;; Use Clojure's reduce function or its apply function to turn 
;; the strings into numbers and then adds them together.

(defn add-strings [& strings]
    (apply + (map #(Integer/parseInt %) strings))
   )


(println (add-strings "10")) ;prints 10
(println (add-strings "10" "20")) ;prints 30
(println (add-strings "10" "20" "30")) ;prints 60
(println (add-strings "10" "20" "30" "40")) ;prints 100