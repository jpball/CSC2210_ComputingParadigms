;; Write a clojure function that takes two dates and returns the number of days in between those two dates.
;; So, if the supplied dates are:
;; 3/19/1973 and 10/12/2020
;; the program should display that there are 17374 days in between (include the starting date but do not include the ending date).
;; If the supplied dates are:
;; 1/1/2000 and 10/12/2020
;; the program should display that there are 7590 days in between.
;; The function must be called 'get-number-of-days-in-between' and it may be called like this (the '/' will separate month, day, and year):
;; It is also possible that the user will enter in dates separated by a dash:
;; If the function is called without parameters then the function should prompt the user to enter in two dates.
;; (get-number-of-days-in-between)
;; Enter in the first date?
;; 3/19/1973
;; Enter in the second date?
;; 10-12-2020
;; There are 17374 days in between 3/19/1973 and 10/12/2020

;; Hints:
;; - there should not be a single call to def in this program. The def function is used for storing global variables. 
;; We generally don't use globals.
;; - use maps to hold data and create functions that return them (perhaps to be sent to other functions)
;; - build and test this program in very small pieces. Here are the names of some of the functions that you may need:
;; get-month [date-string]
;; get-day [date-string]
;; get-year [date-string]
;; leap-year? [year]
;; ...
;; ...

;; - use the built in java classes to do things like split a string, convert a string to an int, etc.
;; - look at my example Clojure programs to learn about all of the built in functions.
;; - use let to hold temporary values of calculations
;; - remember the functions map, reduce, range
;; - the algorithms to find the days in between two dates is different if the dates are in the same year
(defn leap-year? [year]
  (if (and 
       (zero? (mod year 4)) 
       (not 
        (zero? (mod year 100)))
       ) 
    true
    (if (zero? (mod year 400)) true false))
  ) 

(defn create-date-map [string]
  (let [date (clojure.string/split string #"[-/]")
        month (Integer/parseInt (nth date 0))
        day (Integer/parseInt (nth date 1))
        year (Integer/parseInt (nth date 2))]
    {:month month :day day :year year})
  ) 

(defn get-number-of-days-in-between [date1, date2] 
  (let d1)
  )

(println (get-number-of-days-in-between "3/19/1973" "11/3/2017")) ;;16300
(println (get-number-of-days-in-between "1/1/2000" "11/3/2017")) ;;6516
(println (get-number-of-days-in-between "11/2/2017" "11/3/2017")) ;;1