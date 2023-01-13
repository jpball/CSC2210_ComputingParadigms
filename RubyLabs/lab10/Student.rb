require_relative 'Student'

=begin
+ Remember, each student has a gpa and name. 
+ Plain old students have a scale from 0-4. 
=end

class Student
    attr_accessor(:firstName)
    attr_accessor(:lastName)

    @@LowerGPABound = 0.0
    @@UpperGPABound = 4.0

    def initialize(f, l, g)
        self.firstName = f
        self.lastName = l
        self.GPA = g
    end

    def fullName
        @firstName + " " + @lastName
    end

    def GPA=(g)
        if(g >= @@LowerGPABound and g <= @@UpperGPABound)
            @GPA = g
        else
            if(g > @@UpperGPABound)
                @GPA = @@UpperGPABound
            elsif(g < @@LowerGPABound)
                @GPA = @@LowerGPABound
            end
        end
    end

    def to_s 
        return "Student: #{@firstName} #{@lastName} -> #{@GPA}" 
    end 
end