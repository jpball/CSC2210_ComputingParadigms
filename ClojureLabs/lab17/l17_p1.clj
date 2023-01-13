; The first Clojure program will prompt the user for the length and width 
; of a wooden board in inches. 
; Then display the number of whole square feet are in the board. 
; For example, if the length is 27 inches and the width is 34 inches, 
; then the number of square feet is 6.375.

(println "Please enter a length in inches:")
(def length (. Integer parseInt (read-line)) )
(println "Please enter a width in inches:")
(def width (. Integer parseInt (read-line)))

(def sqft (/ (* length width) 144.0))
(println (str "The board is " sqft " square feet"))
