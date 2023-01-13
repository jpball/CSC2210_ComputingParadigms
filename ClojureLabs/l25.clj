;; Write a function that will join a series of strings together separated by another string. 
;; The function should create and return a new string. 
;; Use recursion (with either recur) with a loop or a helper function.



;;  ;;"Mark, Laura, Buddy, Patrick, Willy"

(defn join [separator & parts]
  (let [union (reduce (fn [so_far, word] (str so_far (str word separator))) "" parts)] 
    (subs union 0 (clojure.string/last-index-of union separator))
    ))

(println (join ", " "Mark" "Laura" "Buddy" "Patrick" "Willy"))