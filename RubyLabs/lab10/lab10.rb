=begin
This lab asks you to create the student and foreign exchange 
    student hierarchy of classes in Ruby (this is the equivalent program in C++). 

Remember, each student has a gpa and name. 

There are methods to get and set each data member and to print.

+ Foreign exchange students have a gpa scale from 1-10. 
+ Plain old students have a scale from 0-4. 
+ Foreign exchange students also have a homeCountry attribute that 
        regular students do not.
=end
require_relative 'Student'
require_relative 'ForeignExchangeStudent'

FirstNames = ["Jordan", "Mark", "Lucy", "Bob", "Jerry", "Cindy", "Larry", "Jessie"]

def __MAIN()
	s1 = Student.new("Jordan", "Ball", 5.29)
	f1 = ForeignExchangeStudent.new("Bob", "Smith", 9.32, "England")
	puts("\n\n\n")
	puts(s1.to_s)
	puts(f1.to_s)
	puts("\n\n\n")
end

__MAIN()

