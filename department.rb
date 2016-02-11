require './employee.rb'

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

  def give_raises(total: nil, each: nil)

    if total
      raise_eligible = @employees.select {|x| x.is_satisfactory? || x.review == nil}
      each_amount = total / raise_eligible.length

      raise_eligible.each {|x| x.give_raise!(amount: each_amount)}
    end

    if each
      raise_eligible = @employees.select {|x| yield(x)}

      raise_eligible.each {|x| x.give_raise!(amount: each)}
    end

  end

end
