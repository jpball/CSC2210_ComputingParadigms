;; Write a recursive function to reverse the letters of a string.

;; You may need to create a recursive 'helper' function that takes a 
;; different number of parameters than the non-recursive function or 
;; use the loop form. 

;; Make sure you use recursion with the recur form 
;; so that you do not 'blow the stack'. Write tests 
;; to verify that your function works correctly.

(defn reverse-helper [str_so_far, next_index, word]
  (if (< next_index 0)
  str_so_far
  (recur (str str_so_far (get word next_index)) (dec next_index) word))
  )

(defn reverse-string [word]
  (reverse-helper "" (dec (count word)) word)
  )
(println (reverse-string "Mark Mahoney"))
(println (reverse-string "Jordan Ball"))

