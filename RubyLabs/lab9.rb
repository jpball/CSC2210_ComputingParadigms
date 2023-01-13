=begin
    
Ruby arrays have several useful methods built in to them. 

This makes manipulating the elements in an array easier than in languages 
    with simple arrays. 
    
This lab asks you to rewrite some of the array methods to 
    further show how closures can make writing some code easier.

Each method will take an array as a parameter. 

This is an array of numbers that I will use to test my version of the 
    array/enumerable methods:
- each()
- collect()
- all?()
- any?()
- find()
- find_all()
- inject()

Name your methods like this:

    - my_each(arr)
    - my_collect(arr)
    - my_all?(arr)
    - my_any?(arr)
    - my_find(arr, elem)
    - my_find_all(arr, elem)
    - my_inject(arr)
    
=end
def my_each(arr)
    # The method takes a block of code and loops through all of the elements in it.
    0.upto(arr.length-1) do |x|
        yield arr[x]
    end
end
# ---
def my_collect(arr)
    # The collect method generates a new value for every one in the array.
    newArr = []
    my_each(arr) do |v|
        newArr << (yield v)
    end
    return newArr
end
# ---
def my_all?(arr)
    # The Array's all? method will iterate through 
    # an array and return true if all of the elements satisfies some condition. 
    retVal = true;
    my_each(arr) do |v|
        if(!yield v)
            retVal = false
            break
        end
    end
    return retVal
end
# ---
def my_any?(arr)
    # The Array's any? method is similar to all? 
    # except that if any element in the array satisfies a 
    # condition then the method returns true. 
    retVal = false;
    my_each(arr) do |v|
        if(yield v)
            retVal = true
            break
        end
    end
    return retVal
end
# ---
def my_find(arr)
    # The Array find method will return the first element that satisfies a condition.
    my_each(arr) do |v|
        if(yield v)
            return v
        end
    end
    return nil
end
# ---
def my_find_all(arr, elem = nil)
    newArr = []
    my_each(arr) do |v|
        if(v == elem or yield v)
            newArr << v
        end
    end
    return newArr
end
# ---
def my_inject(arr, initValue)
    # The Array inject method iterates through 
    # all of the elements in an array and applies 
    # an operation to each one in order to reduce 
    # them to a single value. 
    # Often this is used to accumulate values in an array.
    accumulator = initValue 
    for index in 0...arr.length do 
        accumulator = yield accumulator, arr[index] 
    end         
    return accumulator 
end
# ---
def __MAIN()
    arr = (0..20).to_a
    v = my_inject(arr, 1) {|x, y|  x + y} 
    puts(v.to_s)
end

__MAIN()