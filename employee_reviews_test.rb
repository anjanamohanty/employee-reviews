require 'minitest/autorun'
require 'minitest/pride'

require './employee.rb'
require './department.rb'

class EmployeeReviewsTest < Minitest::Test

  def test_classes_exist
    assert Employee
    assert Department
  end

  # Create a new department (given its name).
  def test_can_creat_new_department_with_name
    assert Department.new("Computer Science")
  end

  # Create a new employee (given his/her name, email address, phone number, and salary).

  # Add an employee to a department.

  # Get an employee's name.

  # Get an employee's salary.

  # Get a department's name.

  # Get a total salary for all employees in a department.

  # Add some employee review text (a paragraph or two) to an employee.

  # Mark whether an employee is performing satisfactorily or not satisfactorily.

  # Give a raise to an individual. You decide if this makes sense in dollars or in percent.

  # Give raises to a department's employees. You must pass this method a total dollar amount,
  # and it must distribute the raise amounts reasonably to the department's employees.
  # Only employees who are performing satisfactorily should get raises.

end
