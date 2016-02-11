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

  def give_raises(amount)
    raise_eligible = @employees.select {|x| x.performance == :satisfactory || x.performance == nil}
    each_amount = amount / raise_eligible.length
    raise_eligible.each {|x| x.give_raise!(amount: each_amount)}
  end

end
