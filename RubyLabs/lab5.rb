=begin

Lab 5 asks you to write a program that creates several student hashes. 
Each student hash should have members for a first name, last name, and a gpa. 
Write a method that prompts for the student info and returns the hash.

#a hash is kind of like a struct
student1 = {
  :first_name => "Mark",
  :last_name => "Mahoney",
  :gpa => 3.2
}
Add each of the students to an array.

#in a loop
  all_students << prompt_for_student()
Pass the array filled with students in to a method that finds the average gpa.
=end

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


