class Employee
  attr_accessor :name, :title, :status, :location
  attr_reader :id

  def initialize(name, title, location, id, status = 'active')
    @name = name
    @title = title
    @status = status
    @location = location
    @id = id
  end
end

@next_id = 1000
@all_emps = []
@current_emp = nil
@possible_locations = ['Asheville, NC', 'Malibu, CA', 'The Moon (remote)']

# test content
@all_emps.push Employee.new('name1', 'title1', 'location', @next_id += 1)
@all_emps.push Employee.new('name2', 'title2', 'location', @next_id += 1)
@all_emps.push Employee.new('name3', 'title3', 'location', @next_id += 1)
@all_emps.push Employee.new('name4', 'title4', 'location', @next_id += 1)
# test content

def main_menu
  puts '1. Add New Employee to Database'
  puts '2. Edit Existing Employee Details'
  puts '3. View database'

  choice = 0
  choice = gets.chomp.to_i until (1..3).cover? choice
  case choice
  when 1
    add_emp
  when 2
    employee_lookup
  when 3
    database_menu
    # create menu
  end
end

def employee_lookup
  list_emp
  puts 'Enter employee ID'
  emp_id = gets.chomp.to_i
  @all_emps.each_with_index do |emp, index|
    if emp.id.to_i == emp_id.to_i
      @current_emp = emp
      @current_emp_index = index
      clear_screen
      puts "Current selected employee: #{emp.id}: #{emp.name}" # TODO: display all employee properties
      puts '-------------------------------------------------'
      edit_emp
    end
  end
  puts "No employee ID found: #{emp_id}"
  main_menu
end

def edit_emp
  puts 'What would you like to edit?'
  puts '1. Employee Name?'
  puts '2. Employee Title?'
  puts '3. Location'
  puts '4. Status'
  puts '5. Return to menu'
  choice = 0
  choice = gets.chomp.to_i until (1..5).cover? choice
  case choice
  when 1
    print 'New Name: '
    new_name = ''
    new_name = gets.chomp while new_name == ''
    puts "Employee: #{@current_emp.id}:"
    puts "Old name: #{@current_emp.name}"
    @current_emp.name = new_name
    puts "New name: #{@current_emp.name}"
    @all_emps[@current_emp_index] = @current_emp
    edit_emp
  when 2
    print 'New Employee Title: '
    new_title = ''
    new_title = gets.chomp while new_title == ''
    puts "Employee: #{@current_emp.id}: #{@current_emp.name}"
    puts "Old title: #{@current_emp.title}"
    @current_emp.title = new_title
    puts "New title: #{@current_emp.title}"
    @all_emps[@current_emp_index] = @current_emp
    edit_emp
  when 3
    change_location
  when 4
    change_status
  when 5
    main_menu
  end
end

def change_location
  locations_list # ***
  puts "#{@possible_locations.length + 1}: Add new location"
  choice = gets.chomp.to_i until (1..@possible_locations.length + 1).cover? choice
  if choice <= @possible_locations.length
    @current_emp.location = @possible_locations[choice - 1]
  else
    puts 'Enter new location to add to database'
    new_location = ''
    new_location = gets.chomp while new_location == ''
    @possible_locations.push new_location
    puts 'New location has been saved!'
    @current_emp.location = new_location
  end
  @all_emps[@current_emp_index] = @current_emp # TODO: success message for emp update
  edit_emp
end

# TODO: make this work like change_location
def change_status
  puts 'Edit employee status'
  puts '1. Mark employee as inactive'
  puts '2. Add new employee status'
  case gets.chomp.to_i
  when 1
    remove_emp
  when 2
    puts 'define new employee status'
    add_employee_status = ''
    add_employee_status = gets.chomp while add_employee_status == ''
    puts "Employee: #{@current_emp.id}:"
    puts "Old status: #{@current_emp.status}"
    @current_emp.status = add_employee_status
    puts "New status: #{@current_emp.status}"
    edit_emp
  end
end

def add_emp
  puts 'Add new employee'
  print 'Employee name: '
  name = gets.chomp
  print 'Employee title: '
  title = gets.chomp
  puts 'Possible locations'
  puts '------------------'
  locations_list # *** DUPLICATE CODE FROM change_location
  puts "#{@possible_locations.length + 1}: Add new location"
  choice = gets.chomp.to_i until (1..@possible_locations.length + 1).cover? choice
  if choice <= @possible_locations.length
    location = @possible_locations[choice - 1]
  else
    puts 'Enter new location to add to database'
    location = ''
    location = gets.chomp while location == ''
    @possible_locations.push location
    puts 'New location has been saved!'
  end
  @current_emp = Employee.new(name, title, location, @next_id += 1)
  @all_emps.push @current_emp
  main_menu
end

def remove_emp
  answer = 0
  until [1, 2].include? answer
    puts "You have selected to bump #{@current_emp.name}"
    puts 'Are you sure you want to put on the concrete boots?
    1. Yes
    2. No'
    answer = gets.chomp.to_i
    case answer
    when 1
      puts "#{@current_emp.name} goes 'glub, glub, glub'"
      @all_emps.delete(@current_emp)
      puts "#{@current_emp.name} is feeding the fish"
      list_emp
      # puts "Press [ENTER] to go back to menu"
      # gets.chomp
      # clear_screen
      main_menu
    when 2
      menu
    else
      puts 'Be sure next time'
    end
  end
end

def locations_list
  @possible_locations.each_with_index do |location, index|
    puts "#{index + 1}: #{location}"
    @all_emps.each do |employee|
      puts employee.name if employee.location == location
    end
  end
end

# def remove_location
#
# end

# TODO: take argument to list all or partial employee properties
def list_emp
  puts 'Employee list'
  list = @all_emps.map { |emp| [emp.id, emp.name] }
  puts 'ID: NAME:'
  puts '---------'
  list.each do |pair|
    puts "#{pair[0]}: #{pair[1]}"
  end
end

def full_list_emp
  puts 'Employee list'
  @all_emp.each do |employee|
    print "Name: #{employee.name}"
    puts "   title: #{employee.title} Status: #{employee.status} Location: #{employee.location} ID: #{employee.id}"
  end
end

def clear_screen
  system 'cls' or system 'clear'
end

main_menu
