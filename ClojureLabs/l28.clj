;; Write a function that generates an infinite lazy sequence of increasing 
;; numbers divisible by a passed in value. 

;; The first parameter is the number that all the values in the sequence must be divisible by. 
;; The second parameter is the starting value. 

;; If the starting value is not divisible by the first parameter 
;; then you must find the first value that is and begin the sequence from there.
(use 'clojure.test)


(defn div-by [divisor start-val]
    (lazy-seq
     (if (zero? (mod start-val divisor))
         (cons start-val (div-by divisor (inc start-val)))
         (div-by divisor (inc start-val )))
         )
     ) 

(deftest test-divs
  (is (= (take 5 (div-by 5 10)) '(10 15 20 25 30)))
  (is (= (take 5 (div-by 5 12)) '(15 20 25 30 35)))
  (is (= (take 5 (div-by 50 12)) '(50 100 150 200 250)) ) 
  )
(run-tests)
