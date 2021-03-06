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
@possible_status = %w[Active Inactive Suspended MIA KIA Sectioned Disappeared Fired]

# test content
@all_emps.push Employee.new('name1', 'title1', 'location', @next_id += 1)
@all_emps.push Employee.new('name2', 'title2', 'location', @next_id += 1)
@all_emps.push Employee.new('name3', 'title3', 'location', @next_id += 1)
@all_emps.push Employee.new('name4', 'title4', 'location', @next_id += 1)
# test content

def main_menu
  puts '1. Add New Employee
2. Edit Existing Employee
3. Database Menu'

  choice = 0
  choice = gets.chomp.to_i until (1..3).cover? choice
  case choice
  when 1
    add_emp
  when 2
    employee_lookup
    edit_employee
  when 3
    database_menu
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
      #clear_screen
      return
    end
  end
  puts "No employee ID found: #{emp_id}"
  main_menu
end

def edit_employee
  puts "Current selected employee: #{@current_emp.id}:
-------------------------------------------------
  Name: #{@current_emp.name}
  Location: #{@current_emp.location}
  Status: #{@current_emp.status}
  Title: #{@current_emp.title}
-------------------------------------------------
   What would you like to edit?
   1. Name
   2. Title
   3. Location
   4. Status
   5. Return to menu"
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
    edit_employee
  when 2
    print 'New Employee Title: '
    new_title = ''
    new_title = gets.chomp while new_title == ''
    puts "Employee: #{@current_emp.id}: #{@current_emp.name}"
    puts "Old title: #{@current_emp.title}"
    @current_emp.title = new_title
    puts "New title: #{@current_emp.title}"
    @all_emps[@current_emp_index] = @current_emp
    edit_employee
  when 3
    change_location
  when 4
    change_status
  when 5
    main_menu
  end
end

def change_location
  locations_list() # ***
  puts "#{@possible_locations.length + 1}: Add new location"
  choice = gets.chomp.to_i until (1..@possible_locations.length + 1).cover? choice
  if choice <= @possible_locations.length
    @current_emp.location = @possible_locations[choice - 1]
  else
    @current_emp.location = add_location
  end
  @all_emps[@current_emp_index] = @current_emp # TODO: success message for emp update
  edit_employee
end

def add_location
    puts 'Enter new location to add to database'
    new_location = ''
    new_location = gets.chomp while new_location == ''
    @possible_locations.push new_location
    puts 'New location has been saved!'
    return new_location
end

# TODO: make this work like change_location
def change_status
  status_list # ***
  puts "#{@possible_status.length + 1}: Add new Status"
  choice = gets.chomp.to_i until (1..@possible_status.length + 1).cover? choice
  if choice <= @possible_status.length
    @current_emp.status = @possible_status[choice - 1]
  else
    add_status
  end
  @all_emps[@current_emp_index] = @current_emp # TODO: success message for emp update
  edit_employee
end

def add_status
    puts 'Enter new Status to add to database'
    new_status = ''
    new_status = gets.chomp while new_status == ''
    @possible_status.push new_status
    puts 'New Status has been saved!'
    @current_emp.status = new_status
end

def add_emp
  puts 'Add new employee'
  print 'Employee name: '
  name = gets.chomp
  print 'Employee title: '
  title = gets.chomp
  puts 'Possible locations'
  puts '------------------'
  locations_list() # *** DUPLICATE CODE FROM change_location
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
      return
    when 2
      puts "You've chosen, wisely"
      return
    else
      puts 'Be sure next time'
    end
  end
end

def del_location
  locations_list
  puts "-----------------------------------------"
  print "Enter number of location to delete: "
  choice = gets.chomp.to_i until (1..@possible_locations.length).cover? choice
  if choice <= @possible_locations.length
    @possible_locations.delete_at(choice - 1)
    puts "Location deleted!"
  end
end

def del_status
  status_list
  puts "-----------------------------------------"
  print "Enter number of status to delete: "
  choice = gets.chomp.to_i until (1..@possible_status.length).cover? choice
  if choice <= @possible_status.length
    @possible_status.delete_at(choice - 1)
  end
end

def locations_list(type = :without_emps)
  @possible_locations.each_with_index do |location, index|
    puts "#{index + 1}: #{location}"
    if type == :with_emps
      @all_emps.each do |employee|
        puts employee.name if employee.location == location
      end
    end
  end
end

def status_list
  @possible_status.each_with_index do |status, index|
    puts "#{index + 1}: #{status}"
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
  @all_emps.each do |employee|
    print "Name: #{employee.name}"
    puts "   title: #{employee.title} Status: #{employee.status} Location: #{employee.location} ID: #{employee.id}"
  end
end

def clear_screen
  system 'cls' or system 'clear'
end

def database_menu
puts "_________________
1. View database
2. Add Location
3. Delete Location
4. Delete Employee
5. Add Status
6. Delete Status
7. Main Menu"
  choice = gets.chomp.to_i until (1..7).cover? choice
    case choice
      when 1
        view_database
      when 2
        add_location
      when 3
        del_location
      when 4
        employee_lookup
        remove_emp
      when 5
        add_status
      when 6
        del_status
      when 7
      main_menu
    end
    database_menu
end

def view_database
  puts '1. View Full Employee Data
2. View Employees By Location
3. View Locations
4. Go Back'
  choice = gets.chomp.to_i until (1..4).cover? choice
  case choice
    when 1
      full_list_emp
    when 2
      locations_list(:with_emps)
    when 3
      locations_list()
    when 4
      database_menu
  end
  view_database
end
main_menu
