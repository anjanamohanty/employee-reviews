class Department

  attr_reader :employees
  
  def initialize(name)
    @name = name
    @employees = []
  end

  def add_employee(new_employee)
    @employees << new_employee
  end

end
