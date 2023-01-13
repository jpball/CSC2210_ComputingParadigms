(use '[clojure.test])
(require '[clojure.string :as str])
;; ======================== SPEC ========================
;; This program will be used to determine your base-10 birthdays. 
;; Your base-10 birthday is every 1000 days. 
;; In order to do this you will need some functions that will 
;; lazily generate successive days from a starting point.

;; Write two lazy date string generators that create 
;; every single date starting from a passed in date until the end of time. 

;; One generator will print in this format:
;; MM/DD/YYYY

;; and the other will print a long date with the month name, day, and year. 
;; For example,
;; April 16, 2017

;; Write tests using clojure's testing framework to verify 
;; that all of your functions work correctly.
;; ========================================================
;; Generate a lazy sequence of sequetial dates

;; Structures to hold the month names and days in each month
(def days-in-months {1 31, 2 28, 3 31, 4 30, 5 31, 6 30, 7 31, 8 31, 9 30, 10 31, 11 30, 12 31})
(def days-in-months-leapyear (assoc days-in-months 2 29))
(def str-months (assoc days-in-months 1 "January", 2 "February", 3 "March", 4 "April", 5 "May", 6 "June", 7 "July", 8 "August", 9 "September", 10 "October", 11 "November", 12 "December"))

(defn is-leap-year? [year]
  (if (and (zero? (mod year 4)) (not (zero? (mod year 100))))
    true
    (if (zero? (mod year 400))
      true
      false)))

;; Will return a map of the date
(defn create-date [string_date_short]
  (let [dateList (str/split string_date_short #"/")
        month (->> (nth dateList 0) (. Integer parseInt))
        day (->> (nth dateList 1) (. Integer parseInt))
        year (->> (nth dateList 2) (. Integer parseInt))]
    {:day day :month month :year year}))

;; Given a date-map
;; Returns a new date-map of the following day
;; Watch out for leap years
(defn get-next-day [date-map]
  (let [day (date-map :day)
        month (date-map :month)
        year (date-map :year)]

    (if (= month 2)
      ;; True -> We are in february
      (if (is-leap-year? year)
        ;; True -> Feb. leap year
        (if (= day (get days-in-months-leapyear month))
          ;; True -> Final day of Feb in leap year
          (assoc date-map :day 1 :month 3)
          
          ;; False -> Non-Final day of Feb. in leap year
          (assoc date-map :day (inc day))
          )
        
        ;; False -> Feb. normal year  
        (if (= day (get days-in-months month))
          ;; True -> Final day of Feb in leap year
          (assoc date-map :day 1 :month 3)

          ;; False -> Non-Final day of Feb. in leap year
          (assoc date-map :day (inc day)))
        )
      
      ;; False -> Not February
      (if (= month 12)
        ;; True -> Decemeber
        (if (= day (get days-in-months 12))
          ;; True -> Final day of Dec.
          (assoc date-map :day 1 :month 1 :year (inc year))
          ;; False -> Non-Final day of Dec.
          (assoc date-map :day (inc day)) 
          )
        ;; False -> Non-Dec month
         (if (= day (get days-in-months month))
           ;; True -> Final day of month
           (assoc date-map :day 1 :month (inc month))
           ;; False -> Non-Final day of month
           (assoc date-map :day (inc day)) 
           ) 
        )
      )
  )
)

;; MM/DD/YYYY
(defn date-map-to-string-short [date-map]
  (let [day (date-map :day)
        month (date-map :month)
        year (date-map :year)
        
        day-str (if (>= day 10) day (str "0" day))
        month-str (if (>= month 10) month (str "0" month))
        ]
    
    (str month-str "/" day-str "/" year) 
   )
)

(defn format-date-str [string]
  (date-map-to-string-short (create-date string)) 
  )


;; Given a short date str (i.e. "MM/DD/YYYY")
;; Return the modified date str in the long for (i.e. "April 16, 2017")
(defn short-date-str-to-long-date-str [short_date_str]
  (let [date-map (create-date short_date_str)
        day (date-map :day)
        month (date-map :month)
        year (date-map :year)]
    (str (str-months month) " " day ", " year)
    ) 
  )

(defn get-dates [start_date_str_short]
  (lazy-seq
   (cons
    (format-date-str start_date_str_short)
    (get-dates (date-map-to-string-short (get-next-day (create-date start_date_str_short))))))
  )

(defn get-dates-long 
  [start_date_str_short]
  (lazy-seq
   (cons (short-date-str-to-long-date-str start_date_str_short)
         (get-dates-long (date-map-to-string-short (get-next-day (create-date start_date_str_short)))))))


;; *****************************************************************
;; *******************       TESTS        **************************
;; *****************************************************************
;; *****************************************************************

;; Test the get-dates lazy sequence
(deftest test-get-dates-lz-seq-short-fn
  (are [call result] (= call result)
    (nth (get-dates "11/8/2017") 0) "11/08/2017"
    (nth (get-dates "11/8/2017") 1) "11/09/2017"
    (nth (get-dates "11/8/2017") 2) "11/10/2017"
    (take 5 (get-dates "11/8/2017")) `("11/08/2017" "11/09/2017" "11/10/2017" "11/11/2017" "11/12/2017")
    (take 1 (get-dates "2/8/2017")) `("02/08/2017")
    (nth (get-dates "01/01/2017") 77) "03/19/2017"
    )
)

;; Test the get-dates-long lazy sequence
(deftest test-get-dates-lz-seq-long-fn
  (are [call result] (= call result)
    (nth (get-dates-long "01/01/2017") 77) "March 19, 2017"
    (nth (get-dates-long "01/01/1970") 17478) "November 8, 2017"
    (nth (get-dates-long "11/28/1999") 500) "April 11, 2001"
    (nth (get-dates-long "02/29/2000") 3) "March 3, 2000"
    (nth (get-dates-long "03/03/1988") 20) "March 23, 1988"
    (nth (get-dates-long "06/06/2022") 2) "June 8, 2022")
  )

;; Tests testing the validity of our leapyear function
(deftest test-leapyear-fn
  (are [input result] (= (is-leap-year? input) result)
    2000 true
    2400 true
    2020 true
    2024 true
    1700 false
    2100 false
    2200 false
    2321 false))

;; Tests the create-map function
(deftest test-create-map-fn
  (are [string date] (= (create-date string) date)
    "01/01/1973" {:day 1 :month 1 :year 1973}
    "03/03/2002" {:day 3 :month 3 :year 2002}
    "11/04/1976" {:day 4 :month 11 :year 1976}
    "9/5/1923" {:day 5 :month 9 :year 1923}
    "10/6/1988" {:day 6 :month 10 :year 1988}
    "11/7/2022" {:day 7 :month 11 :year 2022}))

;; Tests the get-next-day 
(deftest test-get-next-day
  (are [start-date-str result-map] (= (get-next-day (create-date start-date-str)) result-map)
    "01/01/1973" {:day 2 :month 1 :year 1973}
    "01/31/1973" {:day 1 :month 2 :year 1973}
    "12/31/1999" {:day 1 :month 1 :year 2000}
    "11/30/1976" {:day 1 :month 12 :year 1976}
    "2/28/2000" {:day 29 :month 2 :year 2000}
    "2/28/2001" {:day 1 :month 3 :year 2001} 
    ))


;; run all test methods
(run-tests)

;; *****************************************************************
;; In addition to the tests, use your functions to print out your first 
;; thirty base-10 birthdays in long format. Look at the built-in 
;; take-nth function to help you retrieve and display them.
(println "================================================")
(println "First 30 base-10 birthdays:")
(doseq [date (take 30 (take-nth 1000 (get-dates-long "11/28/2000"))) ]
        (println date))

