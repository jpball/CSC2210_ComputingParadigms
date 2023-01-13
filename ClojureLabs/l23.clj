;; Write an overloaded function (with two bodies) that will 
;; find the average length of words in a string (all words are separated by whitespace)

;; The first version will take a string. 
;; The second version will take no parameters but 
;; will prompt the user to type in a sentence to be analyzed. 
;; You can call one version of this function from the other.
(defn find-average
  ([string]
    (let [words (clojure.string/split string #" ")]
      (reduce + (map count words)) (/ (count words))))
  
  
    ([]
     (println "Enter a sentence to be analyzed: ")
     (let [string (read-line)]
       (find-average string)))
  )
  

(println (find-average "The quick brown fox jumped over the fence"))