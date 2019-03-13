class Employee
  attr_accessor :name, :role, :status, :location
  attr_reader :id

  def initialize(name, role, location, id, status)
    @name = name
    @role = role
    @status = status
    @location = location
    @id = id
  end
end
