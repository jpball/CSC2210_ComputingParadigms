require_relative 'Student'

=begin
+ Foreign exchange students have a gpa scale from 1-10. 
+ Foreign exchange students also have a homeCountry attribute that 
        regular students do not.
=end

class ForeignExchangeStudent < Student
    @@FESLowerGPABound = 1.0
    @@FESUpperGPABound = 10.0

    attr_accessor :homeCountry
    attr_accessor :GPA
    
    def initialize(f, l, g, hC)
        super(f,l,g)
        @homeCountry = hC
    end

    def GPA=(g)
        if(g >= @@FESLowerGPABound and g <= @@FESUpperGPABound)
            @GPA = g
        else
            if(g > @@FESUpperGPABound)
                @GPA = @@FESUpperGPABound
            elsif(g < @@FESLowerGPABound)
                @GPA = @@FESLowerGPABound
            end
        end
    end

    def to_s
        return "F.E.Student: #{@firstName} #{@lastName} -> #{@GPA} from #{@homeCountry}" 
    end
end