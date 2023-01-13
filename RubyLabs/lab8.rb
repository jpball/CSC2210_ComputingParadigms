=begin
Lab 8 asks you to write a program that creates several student hashes. 
    Each student hash should have members for a first name, last name, and a gpa.

#a hash is kind of like a struct
student1 = {
  :first_name => "Mark",
  :last_name => "Mahoney",
  :gpa => 3.2
}
Add each of the students to an array.

all_students << student1
all_students << student2
all_students << student3
...
Pass the array filled with students in to a function that will 
identify high gpa students and yield each high gpa student to a 
block of code (the minimum gpa is passed in to the function 
    as a parameter along with the array of students).

Call the function and pass in a block of code that prints the 
    names of the students with a gpa of at least 3.0. 
Call the function again and pass in a block of code to find the 
    average gpa for students who earned a 3.75 or higher.
    def prompt_for_student()
  student = {}
  print("Enter a name: ")
  student[:first_name], student[:last_name] = gets.chomp.split
  print("Please enter a GPA: ")
  student[:gpa] = gets.chomp.to_f
  puts()
  puts()
  #puts("Student #{student[:last_name]}, #{student[:first_name]} (#{student[:gpa]}) added.")
  yield student
end

print("How many students?: ")
numStudents = gets.chomp.to_i
all_students = []

numStudents.times do
    prompt_for_student() do |stu|
      all_students.push(stu)
    end
end

puts
puts
puts("== Printing all students ==")
avgGpa = 0.0;
all_students.each do |stu|
    avgGpa += stu[:gpa].to_f
    puts("Student:: #{stu[:first_name]} #{stu[:last_name]} has #{stu[:gpa]}")
end
puts("Average GPA:    #{avgGpa / all_students.length}")
=end
# --
def CreateStudents()
    arr = []

    student1 = {
        :first_name => "Mark",
        :last_name => "Mahoney",
        :gpa => 3.2
    }
    student2 = {
        :first_name => "Jordan",
        :last_name => "Ball",
        :gpa => 4.0
    }
    student3 = {
        :first_name => "Jerry",
        :last_name => "Smith",
        :gpa => 3.95
    }
    student4 = {
        :first_name => "Hugh",
        :last_name => "Jackman",
        :gpa => 2.15
    }
    student5 = {
        :first_name => "Ryan",
        :last_name => "Reynolds",
        :gpa => 3.96
    }

    arr << student1
    arr << student2
    arr << student3
    arr << student4
    arr << student5

    return arr
end
# --
def get_students_by_gpa(all_students, min_gpa)
    #yield the students who have the min gpa
    all_students.each do |stu|
        if( stu[:gpa] >= min_gpa )
            yield stu
        end
    end
end
# --
def PrintStudentInfo(student)
    puts("#{student[:first_name]} #{student[:last_name]} had #{student[:gpa]}")
end
# --
def __MAIN()
    all_students = CreateStudents()


    minGPA = 3.0
    puts("=== Students with atleast a #{minGPA} ===")
    get_students_by_gpa(all_students, minGPA) do |stu|
        PrintStudentInfo(stu)
    end

    print("** Average GPA: ")
    sum = 0.0
    get_students_by_gpa(all_students, 3.75) do |stu|
        sum += stu[:gpa]
    end
    print("#{sum / all_students.length}\n")
end

# Call Main
__MAIN()