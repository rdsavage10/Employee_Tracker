require_relative "employee_class"

def new_employee
puts 'Add new employee'
print 'Employee name: '
name = gets.chomp
prints 'Employee role: '
role = gets.chomp
puts 'Possible locations'
puts @location
prints 'Employee location'
location = gets.chomp
@current_employee = Employee.new(name, role, location)
menu
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
