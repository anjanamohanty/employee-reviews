require 'minitest/autorun'
require 'minitest/pride'

require './employee.rb'
require './department.rb'

class EmployeeReviewsTest < Minitest::Test

  def test_classes_exist
    assert Employee
    assert Department
  end

  # PART ONE

  # Create a new department (given its name).
  def test_can_create_department
    assert Department.new("Computer Science")
  end

  # Create a new employee (given his/her name, email address, phone number, and salary).
  def test_can_create_employee
    assert Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)
  end

  # Add an employee to a department.
  def test_can_add_employee_to_department
    d = Department.new("Computer Science")
    d.add_employee(Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000))

    assert_equal Array, d.employees.class
    assert_equal Employee, d.employees.first.class
  end

  # Get an employee's name.
  def test_can_get_employees_name
    e = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)

    assert_equal "Mason Matthews", e.name
  end

  # Get an employee's salary.
  def test_can_get_employees_salary
    e = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)

    assert_equal 200000, e.salary
  end

  # Get a department's name.
  def test_can_get_departments_name
    d = Department.new("Computer Science")

    assert_equal "Computer Science", d.name
  end

  # Get a total salary for all employees in a department.
  def test_can_get_total_salary_for_all_employees_in_department
    d = Department.new("Computer Science")
    d.add_employee(Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000))
    d.add_employee(Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 200000))

    assert_equal 400000, d.get_salary_total
  end

  # Add some employee review text (a paragraph or two) to an employee.
  def test_can_add_review_text_to_an_employee
    e = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)
    review_text = "Aliqua fap tousled distillery, scenester reprehenderit poutine
    brunch mustache vinyl williamsburg listicle yr post-ironic put a bird on it.
    Hoodie kombucha waistcoat, nesciunt franzen esse velit pitchfork cronut.
    Wolf salvia gluten-free nisi, assumenda ramps four loko butcher raw denim narwhal
    ennui veniam pabst. Adipisicing helvetica reprehenderit, nulla tattooed keytar."

    assert e.add_review(review_text)
    assert_equal review_text, e.get_review
  end

  # Mark whether an employee is performing satisfactorily or not satisfactorily.
  def test_can_mark_employee_performance
    e = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)

    e.mark_performance(:unsatisfactory)
    assert_equal :unsatisfactory, e.performance

    f = Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 200000)

    f.mark_performance(:satisfactory)
    assert_equal :satisfactory, f.performance
  end

  # Give a raise to an individual. You decide if this makes sense in dollars or in percent.
  def test_can_give_employee_a_raise
    e = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)
    raise_percent = 0.1
    e.give_raise!(percentage: raise_percent)

    assert_equal 220000, e.salary

    f = Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 200000)
    raise_amount = 20000
    f.give_raise!(amount: raise_amount)

    assert_equal 220000, f.salary
  end

  # Give raises to a department's employees. You must pass this method a total dollar amount,
  # and it must distribute the raise amounts reasonably to the department's employees.
  def test_can_give_raises_to_departments_employees
    d = Department.new("Computer Science")
    d.add_employee(Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000))
    d.add_employee(Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 200000))

    total_raise_amount = 50000
    d.give_raises(total: total_raise_amount)

    assert_equal 450000, d.get_salary_total
  end

  # Only employees who are performing satisfactorily should get raises.
  def test_cannot_give_raises_to_unsatisfactory_employees
    d = Department.new("Computer Science")
    mason = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)
    clinton = Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 200000)

    d.add_employee(mason)
    d.add_employee(clinton)

    mason.mark_performance(:unsatisfactory)
    clinton.mark_performance(:satisfactory)

    total_raise_amount = 50000
    d.give_raises(total: total_raise_amount)

    assert_equal 450000, d.get_salary_total
    assert_equal 200000, mason.salary
    assert_equal 250000, clinton.salary
  end

  # PART TWO

  # Once your baseline app is complete, modify your method on Departments which gives out raises.
  # It should now take a block which will specify which employees are eligible for raises.
  # Prior to this stage, you only allowed "satisfactory" employees to get raises, but now it can be more flexible.

  def test_can_give_raises_to_employees_who_make_less_than_amount
    d = Department.new("Computer Science")
    mason = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 60000)
    clinton = Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 110000)

    d.add_employee(mason)
    d.add_employee(clinton)

    raise_amount = 5000

    d.give_raises(each: 5000) do |employee|
      employee.salary < 100000
    end

    assert_equal 65000, mason.salary
    assert_equal 110000, clinton.salary
  end


end
