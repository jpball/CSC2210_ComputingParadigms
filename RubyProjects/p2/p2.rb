=begin
Write some code to analyze consecutive prime numbers
 
    Write a function that will generate consecutive prime numbers within a range of 
    values and yields pairs to a block of code. 

This function should allow some code to be sent in that examines each set of consecutive primes.
 
Then use the prime generating function by passing in a block of code to: 
- print all consecutive primes in pairs like this [2 3][3 5][5 7]...
- return an array of the differences between the consecutive primes
- return an array of the values directly in the middle of the primes (the primes will be integers but these middle values can be floats)
- return an array of all of the primes (not in pairs)
- find the average difference between consecutive primes
- find the minimum and maximum difference between consecutive primes in a range
(write a separate function for each one of the above requirements)
 
    The consecutive prime function should take explicit parameters for a 
    starting value and an ending value to search for primes in that range and 
    you must write the code to generate primes yourself (don't use any built in libraries to generate primes).

    It should also implicitly take a block of code to execute on the consecutive primes. 
    Prompt the user for the starting and ending value and then do the analysis on that range.
 
    The prime pair generating function should NOT create an array of primes. 
    It should generate prime pairs as they are needed and they should be discarded after the closure is done with them. 
    In other words, if I wanted to process the first 100 million prime pairs 
    I should not need to store all of them in memory at any one point in time. 

    This would be very memory inefficient. 
    At most I need memory only for two primes at a time. 
    This is one argument for using closures in a programming language.
=end
# ---
# print all consecutive primes in pairs like this [2 3][3 5][5 7]...
def PrintConsecutivePrimes(startVal, endVal)
    GenerateConsecutivePrimePairs(startVal, endVal) do |p1, p2|
        print("[#{p1} #{p2}]")
    end
end
# ---
# return an array of the differences between the consecutive primes
def GetDifferencesBetweenConsecutivePrimes(startVal, endVal)
    arr = []
    GenerateConsecutivePrimePairs(startVal, endVal) do |p1, p2|
        arr << p2 - p1
    end
    return arr
end
# ---
# return an array of the values directly in the middle of the primes 
# (the primes will be integers but these middle values can be floats)
def GetMiddleValues(startVal, endVal)
    arr = []
    GenerateConsecutivePrimePairs(startVal, endVal) do |p1, p2|
        arr << ((p2+p1)/2.0)
    end
    return arr
end
# ---
# return an array of all of the primes (not in pairs)
def GetAllPrimes(startVal, endVal)
    arr = []
    GenerateConsecutivePrimePairs(startVal, endVal) do |p1, p2|
        if not arr.include?(p1)
            arr << p1
        end
        arr << p2
    end
    return arr
end
# ---
# find the average difference between consecutive primes
def GetAvgDifference(startVal, endVal)
    sum = 0
    numPairs = 0;

    GenerateConsecutivePrimePairs(startVal, endVal) do |p1, p2|
        sum += (p2 - p1)
        numPairs += 1
    end
    return (sum / (numPairs*1.0))
end
# ---
# find the minimum and maximum difference between consecutive primes in a range
def GetMaxAndMinDifferenceInRange(minRange, maxRange)
    minDiff = maxRange
    maxDiff = 0

    GenerateConsecutivePrimePairs(minRange, maxRange) do |p1, p2|
        diff = p2 - p1
       if diff < minDiff
        minDiff = diff
       elsif diff > maxDiff
        maxDiff = diff
       end
    end
    return minDiff, maxDiff
end
# ---
# Determine whether or not a passed in Integer is prime
# Primeness -> Only divisors are 1 & itself
def IsPrime?(n)
    if n <= 3
        return n > 1
    end
    if n % 2 == 0 || n % 3 == 0
        return false
    end
    i = 5
    stop = n ** 0.5
    while i <= stop
        if( n % i == 0 || n % (i + 2) == 0)
            return false
        end
        i += 6
    end
    return true
end
# ---
# Write a function that will generate consecutive prime numbers within a range of 
# values and yields pairs to a block of code. 
def GenerateConsecutivePrimePairs(startVal, endVal)
    p1, p2 = nil
    startVal.upto(endVal) do |x|
        if(IsPrime?(x))
            p1 = p2
            p2 = x
            if(p1 != nil)
                yield p1, p2
            end
        end
    end
end
# ---
# Analyze the prime numbers in the desired range
# Then print out the analysis
def AnalyzeRange(minV, maxV)
    puts("All Primes Array: #{GetAllPrimes(minV, maxV)}")
    print("Consecutive Pairs: ")
    PrintConsecutivePrimes(minV, maxV)
    puts
    puts("MidValue Array: #{GetMiddleValues(minV, maxV)}")
    puts("Differences Array: #{GetDifferencesBetweenConsecutivePrimes(minV, maxV)}")
    puts("Average Difference: #{GetAvgDifference(minV, maxV)}")
    minD, maxD = GetMaxAndMinDifferenceInRange(minV, maxV)
    puts("Minimum Difference: #{minD}")
    puts("Maximum Difference: #{maxD}")
end
# ---
# FOR TESTING PURPOSES ONLY
=begin
def __TEST_MAIN()
    minV = 2
    maxV = 11
    AnalyzeRange(minV, maxV)
end
=end
# --
def __MAIN()
    print("Enter minimum value:")
    minV = gets.chomp.to_i
    print("Enter maximum value:")
    maxV = gets.chomp.to_i
    AnalyzeRange(minV, maxV)
end
# ---
# CALL __MAIN() OR __TEST_MAIN()
__MAIN()