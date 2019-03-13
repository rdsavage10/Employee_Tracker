class Employee
  attr_accessor :name, :role, :status :location
  attr_reader :id

  def initialize(name, role, status, location, id)
    @name = name
    @role = role
    @status = status
    @location = location
    @id = id
  end

end

next_id = 1001
@all_emps = []
@current_emp = nil
@possible_locations = ["Asheville, NC", "Malibu, CA", "The Moon (remote)"]


def main_menu
  puts "1. Add New Employee to Database"
  puts "2. Edit Existing Employee Details"
  puts "3. View database"

  case gets.chomp.to_i
    when 1
      new_emp
    when 2
      employee_lookup
    when 3
      database_menu
      #create menu
  end

#def emp_exists?(id)
#
#end

def employee_lookup
  puts "Enter employee ID"
  emp_ID = gets.chomp
  @all_emps.each do |emp|
    if emp.id == emp_ID
      @current_employee = emp
      clear_screen
      puts "Current selected employee: #{emp.id}: #{emp.name}"
      puts "-------------------------------------------------"
      edit_employee
    else
      puts "No employee ID found: #{emp_ID}"
      main_menu
    end
  end
end

def edit_employee
  puts "What would you like to edit?"
  puts "1. Employee Name?"
  puts "2. Employee Title?"
  puts "3. Location"
  puts "4. Status"
  until 1..4 === choice
    choice = gets.chomp.to_i
  end
  case choice
    when 1
      puts "Enter new employee name"
      new_name = ""
      while new_name == ""
        new_name = gets.chomp
      end
      puts "Employee: #{@current_emp.id}:"
      puts "Old name: #{@current_emp.name}"
      @current_employee.name = new_name
      puts "New name: #{@current_emp.name}"
      edit_employee
    when 2
      puts "Enter new employee title"
      new_title = ""
      while new_title = ""
      new_title = gets.chomp
      end
      puts "Employee: #{@current_emp.id}:"
      puts "Old title: #{@current_emp.title}"
      @current_emp.title = new_title
      puts "New title: #{@current_emp.title}"
      edit_employee
    when 3
      change_location
    when 4
      active_status
  end
end

def change_location
  puts "1. Assign existing location"
  puts "2. Add new location"
  case gets.chomp.to_i
    when 1
      locations_list
    when 2
      puts "Enter new location to add to database"
      new_location == ""
      while new_location == ""
        new_location =  gets.chomp
      end
      @possible_locations.push new_location
      puts New location has been saved!
  end
end

def active_status
  puts "Edit employee status"
  puts "1. Mark employee as inactive"
  puts "2. Add new employee status"
  case gets.chomp.to_i
    when 1
      remove_employee
    when 2
      puts "define new employee status"
      employee_status =
      #adds to database
      #puts New status received!
  end
end


def new_emp
  puts 'Add new employee'
  print 'Employee name: '
  name = gets.chomp
  prints 'Employee role: '
  role = gets.chomp
  puts 'Possible locations'
  puts '------------------'
  puts @possible_locations
  prints 'Employee location '
  location = gets.chomp
  @current_emp = Employee.new(name, role, "active", location, next_id)
  menu
end

def remove_emp
    puts "What employee would you like to bump?"
    list_emp
    answer = gets.chomp.to_i
    @current_emp = @all_emps[answer - 1]
    while answer != 1 || answer != 2
      puts "You have selected to bump #{@current_emp.name}"
      puts "Are you sure you want to put on the concrete boots?
      1. Yes
      2. No"
      answer = gets.chomp.to_i
      case answer
        when 1
        puts "#{@current_emp.name} goes 'glub, glub, glub'"
          ex_emp = @all_emps.delete(@current_emp)
          puts "#{@current_emp.name} is feeding the fish"
          list_emp
          #puts "Press [ENTER] to go back to menu"
          #gets.chomp
          #clear_screen
          menu
        when 2
          menu
        else
          puts "Be sure next time"
      end
    end
  end


def locations_list
  @possible_locations.each do |location|
      puts "#{index}. #{location}"
      @all_emps.each do |employee|
        if employee.location == location
          puts employee
  end

# def remove_location
#
# end

def list_emp
puts 'Employee list'
@all_emps.each_with_index do |employee, index|
  print "#{index+1}. Name: #{employee.name}"
  end
end

def full_list_emp
puts 'Employee list'
@all_emp.each_with_index do |employee, index|
  print "Name: #{employee.name}"
  puts "   Role: #{employee.role} Status: #{employee.status} Location: #{employee.location} ID: #{employee.id}"
  end
end

def change_location
puts "What employee would you like to bump to a new location?"
list_emp
@current_emp = gets.chomp.to_i
puts "This employee's current location is:"
puts @current_emp.location
puts ""
puts "Where should they move to?"
new_location = gets.chomp
 @current_emp.location = new_location
end

def clear_screen
  system "cls" or system "clear"
end
