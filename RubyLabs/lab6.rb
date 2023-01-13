=begin
Lab 6 asks you to write a program that does exactly what the built in array 
    'join' method does. Write a method tha takes an array 
    and a separator string and returns a new string with the separator string in 
    between all of the elements (but not after the last element).
=end

def join(arr, sep)
    str = ""
    arr.each do |name|
        str += name + sep
    end
    
    return str.delete_suffix(sep)
end


def __MAIN()
    names = ["Mark", "Laura", "Buddy", "Patrick"]
    names_string = join(names, ", ")
    puts names_string #prints Mark, Laura, Buddy, Patrick

    names_string = join(names, " -> ")
    puts names_string #prints Mark -> Laura -> Buddy -> Patrick
end
__MAIN()