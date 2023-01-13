=begin
    
Programming assignment 1 asks you to create a Ruby program that will 
find the number of days in between two dates. 

For example, I would like to know how many days I have been alive. 
My birth date is 3/19/1973 and today's date is 9/20/2022. 

Find out how many whole days are in between these two dates including 
the start and end dates (there are 18,083).

The user will be prompted to enter two dates in a string 
with month, day, and year separated by a slash. 
You should write a series of methods (don't use Ruby classes yet) 
that find the number of days in between dates. 
...
The algorithm to find the number of days between two dates might be different 
if the two dates are in the same year versus in different years. 
    I will check for this. You will submit a single .rb file before midnight of the due date.
=end
# ---
require 'date'
MONTH_DATES = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
# ---
def IsLeapYear(year)
    if year % 4 != 0
        return false
    end

    if year % 100 != 0
        return true
    end

    if year % 400 != 0
        return false
    else
        return true
    end
end
# ---
def ConvertDate(strDate)
    arr = strDate.split("/")
    return {:month => arr[0].to_i, :day => arr[1].to_i, :year => arr[2].to_i}
end
# ---
def GetNumDaysInMonth(month, year)
    if(month == 2 && IsLeapYear(year))
        return 29
    else
        return MONTH_DATES[month - 1]
    end
end
# ---
def GetNumDaysLeftInMonth(day, month, year)
    return (GetNumDaysInMonth(month, year) - day) + 1
end
# ---
def GetNumDaysInYear(year)
    if(IsLeapYear(year))
        return 366
    else
        return 365
    end
end
# ---
def GetNumDaysLeftInYear(day, month, year)
    numDays = 0
    numDays += GetNumDaysLeftInMonth(day, month, year)
    month += 1
    day = 1
    while(month <= 12)
        numDays += GetNumDaysInMonth(month, year)
        month += 1
    end
    return numDays
end
# ---
def GetNumDaysBetweenTwoDates(date1, date2)
    # ASSUME DATE1 COMES BEFORE DATE2
    numDays = 0
    currDate = date1
    if(currDate[:year] < date2[:year])
        numDays += GetNumDaysLeftInYear(currDate[:day], currDate[:month], currDate[:year])
        # Adjust to beginning of the nest year
        currDate[:day] = 1
        currDate[:month] = 1
        currDate[:year] += 1
        while(currDate[:year] < date2[:year])
            numDays += GetNumDaysInYear(currDate[:year])
            currDate[:year] += 1
        end
    end

    # Year has matched at this point
    while(currDate[:month] < date2[:month])
        numDays += GetNumDaysInMonth(currDate[:month], currDate[:year])
        currDate[:month] += 1
    end

    # Month now matches
    numDays += date2[:day] - currDate[:day]

    numDays += 1 # INCLUDE FINAL DAY
    currDate[:day] = date2[:day]
    return numDays
end
# ---
def PromptForDate()
    puts("Please enter date ( XX/XX/XXXX ): ")
    print(":: ")
    return gets.chomp
end
# ---
def GenRandomDate(prng)

    month = prng.rand(1..12)

    year = prng.rand(1900..2000)

    day = prng.rand(1..(MONTH_DATES[month-1]))
    return Date.new(year, month, day), (month.to_s + "/" + day.to_s + "/" + year.to_s)
end
# ---
# TEST FUNCTION THAT GENERATES Random dates and tests our method using Date class
=begin
def __TEST_MAIN()
    0.upto(100) do
        prng = Random.new()
        d1D, d1S, d2D, d2S = nil

        # Loop until we get Date2 after Date1
        loop do
            d1D, d1S = GenRandomDate(prng)
            d2D, d2S = GenRandomDate(prng)
            break if((d1D <=> d2D) == -1)
        end

        # The value we want
        cVal = (((d2D - d1D).to_s.split("/")[0].to_i) + 1) 
        # The value we get
        tVal = GetNumDaysBetweenTwoDates(ConvertDate(d1S), ConvertDate(d2S))
        puts("D1: #{d1D.to_s}    D2: #{d2D.to_s}    got #{(((d2D - d1D).to_s.split("/")[0].to_i) + 1)}")
        raise "Whoops!" unless cVal == tVal  # ERROR MESSAGE ASSERTION
    end
end
=end
# ---
def __MAIN()
    d1 = PromptForDate()
    d2 = PromptForDate()

    d1C = ConvertDate(d1)
    d2C = ConvertDate(d2)
    puts("The number of days between #{d1} & #{d2} is #{GetNumDaysBetweenTwoDates(d1C, d2C)} day(s)")
end


# ** CALL MAIN ** 
#__MAIN()
__TEST_MAIN()

