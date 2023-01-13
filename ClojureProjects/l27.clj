;; Create a function that generates a lazy sequence of squares. 
;; For example, (1 4 9 16 … to infinity). 
;; Write automated tests to verify that the function works correctly.

;; Then write a function that generates a lazy sequence of values raised to a power:
(use 'clojure.test)

(defn get-power [value power]
  (reduce * (repeat power value))
  )

(defn lazy-pow [start-val power]
  (lazy-seq
   (cons (get-power start-val power)
         (lazy-pow (inc start-val) power))
   )
  )


(deftest test-power
  (is (= (get-power 10 5) 100000))
  (is (= (get-power 11 2) 121))
  (is (= (get-power 2 3) 8))
  (is (= (get-power 5 5) 3125))
  )

(deftest test-lazy-power
  (is  (= (take 6 (lazy-pow 10 2)) `(100 121 144 169 196 225)))
  (is  (= (take 6 (lazy-pow 10 3)) `(1000 1331 1728 2197 2744 3375)))
 
  )
(run-tests)
