;; For the second program, 
;; create a map with the number of days 
;; in each of the months called days-in-months. 
;; Use the integers 1-12 as the keys and the number of days 
;; in the months as the values. 
;; Create a second map from the first that has 29 days for February. 
;; Call this one days-in-months-leapyear. 
;; Make sure to do this efficiently (use assoc to create a new value for February). 
;; Create another map with month names as the strings.

(def days-in-months {1 31, 2 28, 3 31, 4 30, 5 31, 6 30, 7 31, 8 31, 9 30, 10 31, 11 30, 12 31})
(def days-in-months-leapyear (assoc days-in-months 2 29))

;; Create another map with month names as strings as the map values, and numbers as keys
;; Be sure to use assoc to create a new map with the month names as the keys and the number of days as the values.
(def str-months (assoc days-in-months 1 "January", 2 "February", 3 "March", 4 "April", 5 "May", 6 "June", 7 "July", 8 "August", 9 "September", 10 "October", 11 "November", 12 "December"))


;; Prompt the user for a month number, day number, and year 
;; and create two new variables, short-string and long-string. 
;; Short string will be in this format month/day/year and 
;; long string will be in this format "MonthName dayNumber, Year". 
;; Print out both of the strings and the number of days in the month you were born. 
;; You do not need to handle leap year for this part of the program.

(println "Please enter a month number:")
(def month_num (. Integer parseInt (read-line)))
(println "Please enter a day number:")
(def day_num (. Integer parseInt (read-line)))
(println "Please enter a year:")
(def year_num (. Integer parseInt (read-line)))
(def short-string (str month_num "/" day_num "/" year_num))
(def long-string (str (get str-months month_num) " " day_num ", " year_num))
(println "Short string: " short-string)
(println "Long string: " long-string)
(println "Days in month: " (get str-months month_num))

