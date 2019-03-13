class Employee
  attr_accessor :name, :role
  att_reader :id, :location

  def initialize(name, role, location)
    @name = name
    @role = role
    @location = location
    @id
  end

  def change_location!(possible_locations, new_location)
    if possible_locations.include? new_location
      @location = new_location
      return true
    else
      return false
    end
  end

end
