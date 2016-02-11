class Department

  attr_reader :employees, :name

  def initialize(name)
    @name = name
    @employees = []
  end

  def add_employee(new_employee)
    @employees << new_employee
  end

  def get_salary_total
    @employees.reduce(0) {|total, x| total + x.salary}
  end

end
