require_relative "employee_class"

def menu
  puts "Employee Database 1000
  1. Add New Employee
  2. Add Location
  3. Change Employee Location
  4. List Locations
  5. List Employees
  6. Remove Employee"
  case gets.chomp.to_i
  when 1
    puts "Create new employee:"
    new_emp
  when 2
    puts "Create new location:"
    new_location
  when 3
    puts "Change employee location:"
    change_location
  when 4
     puts "Biz location list:"
    list_location
  when 5
    puts "List of Employees:"
    list_emp
  when 6
    puts "Your time here has ended:"
    remove_employee
  else
    puts "Invalid entry, try again"
    menu
  end



end

def add_employee

Employee.new(name, role, location)
end



end
def remove_employee
end

def location_list

end

# def remove_location
#
# end

def employee_list

end

def change_location

end


puts "The program Starts Here"
menu
