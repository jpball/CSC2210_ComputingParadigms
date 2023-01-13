;; Write a function that determines whether a number 
;; is prime or not. 
;; Use the range() and filter() 
;; functions to filter out non-primes in a range of values.

;; Hint: look at the not-any?() and mod() functions for 
;; determining whether a number is prime or not. 

(defn isprime? [num]
  (not-any? 
   (fn [n] (= (mod num n) 0)) 
   (range 2 (Math/ceil (Math/sqrt num) )))
)

(println (isprime? 21))
(println (isprime? 23))
(println (isprime? 2000000011))

