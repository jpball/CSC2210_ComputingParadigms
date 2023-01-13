=begin
Lab 7 asks you to write a program that has a function that will 
    generate a user specified number of coin flips. 

The user will pass in the number of flips requested and the 
    function will repeatedly 'flip a coin' and choose either 'heads' or 'tails'. 
    
There is a built in class called Random that will allow 
    you to choose a random number.

For each coin flip the function should yield to a block of 
    code that is passed in to the function. 

Call the function once passing in the number of requested 
    coin flips and a block of code that prints either 
    'heads' or 'tails' based on the coin flip. 
    
Next, call the exact same function again passing in a different block 
    of code to yield that counts the number of 'heads'.
=end

def flip_coin(num_flips) 
    prng = Random.new
    #flip a coin num_flips number of times and yield the result
    0.upto(num_flips) do |n|
        result = prng.rand(2) == 0 ? "heads" : "tails"
        yield result
    end
end



def __MAIN()
    numFlips = 10
    numHeads = 0
    numTails = 0

    flip_coin(numFlips) do |r|
        #puts("#{r}")
        if(r == "heads")
            numHeads += 1
            puts("We rolled #{numHeads} heads")
        else
            numTails += 1
            puts("We rolled #{numTails} tails")
        end
    end
end

__MAIN()