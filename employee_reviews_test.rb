require 'minitest/autorun'
require 'minitest/pride'

require './department.rb'
require './reviews.rb'

class EmployeeReviewsTest < Minitest::Test

  def test_classes_exist
    assert Employee
    assert Department
  end

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
    e.add_review(review_text)

    assert_equal review_text, e.get_review
  end

  # Mark whether an employee is performing satisfactorily or not satisfactorily.
  def test_can_mark_employee_performance
    e = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 200000)
    f = Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 200000)

    e.add_review(negative_review_two)
    f.add_review(positive_review_one)

    assert_equal false, e.is_satisfactory?
    assert_equal true, f.is_satisfactory?
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

    mason.add_review(negative_review_two)
    clinton.add_review(positive_review_one)

    total_raise_amount = 50000
    d.give_raises(total: total_raise_amount)

    assert_equal 450000, d.get_salary_total
    assert_equal 200000, mason.salary
    assert_equal 250000, clinton.salary
  end

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

    d.give_raises(each: raise_amount) do |employee|
      employee.salary < 100000
    end

    assert_equal 65000, mason.salary
    assert_equal 110000, clinton.salary
  end

  def test_can_give_raise_to_employees_with_specific_name
    d = Department.new("Computer Science")
    mason = Employee.new("Mason Matthews", "mason@email.com", "919-555-5555", 60000)
    clinton = Employee.new("Clinton Dreisbach", "clinton@email.com", "919-777-7777", 110000)

    d.add_employee(mason)
    d.add_employee(clinton)
    raise_amount = 10000

    d.give_raises(each: raise_amount) {|employee| employee.name == "Mason Matthews"}

    assert_equal 70000, mason.salary
    assert_equal 110000, clinton.salary
  end

  # Your task is to write a method on the employee class which looks the employee review text stored
  # in an employee instance variable (in Part 1) and return a true or false for whether this employee
  # is performing satisfactorily. This also means that you will be removing the ability for users
  # to manually mark whether an employee is performing satisfactorily. This will now be determined by code.
  def test_can_mark_performance_correctly_based_on_review
    zeke = Employee.new("Zeke Matthews", "zeke@email.com", "919-555-5555", 60000)
    yvonne = Employee.new("Yvonne yvonne", "yvonne@email.com", "919-777-7777", 100000)
    xavier = Employee.new("Xavier", "xavier@email.com", "919-555-5555", 60000)
    wanda = Employee.new("Wanda Sykes", "wanda@email.com", "919-777-7777", 100000)

    zeke.add_review(negative_review_one)
    yvonne.add_review(negative_review_two)
    xavier.add_review(positive_review_one)
    wanda.add_review(positive_review_two)

    assert_equal zeke.is_satisfactory?, false
    assert_equal yvonne.is_satisfactory?, false
    assert_equal xavier.is_satisfactory?, true
    assert_equal wanda.is_satisfactory?, true
  end

  def negative_review_one
    "Zeke is a very positive person and encourages those around him,
    but he has not done well technically this year.  There are two areas in which Zeke has
    room for improvement.  First, when communicating verbally (and sometimes in writing),
    he has a tendency to use more words than are required.  This conversational style does
    put people at ease, which is valuable, but it often makes the meaning difficult to isolate,
    and can cause confusion.

    Second, when discussing new requirements with project managers, less of the information
    is retained by Zeke long-term than is expected.  This has a few negative consequences:
    1) time is spent developing features that are not useful and need to be re-run,
    2) bugs are introduced in the code and not caught because the tests lack the same information,
    and 3) clients are told that certain features are complete when they are inadequate.
    This communication limitation could be the fault of project management, but given that
    other developers appear to retain more information, this is worth discussing further."
  end

  def negative_review_two
    "Thus far, there have been two concerns over Yvonne's performance,
    and both have been discussed with her in internal meetings.  First, in some cases,
    Yvonne takes longer to complete tasks than would normally be expected.  This most
    commonly manifests during development on existing applications, but can sometimes occur
    during development on new projects, often during tasks shared with Andrew.  In order
    to accommodate for these preferences, Yvonne has been putting more time into fewer projects,
    which has gone well.

    Second, while in conversation, Yvonne has a tendency to interrupt, talk over others, and
    increase her volume when in disagreement.  In client meetings, she also can dwell on potential
    issues even if the client or other attendees have clearly ruled the issue out, and can sometimes
    get off topic."
  end

  def positive_review_one
    "Xavier is a huge asset to SciMed and is a pleasure to work with.  He
    quickly knocks out tasks assigned to him, implements code that rarely needs to be revisited,
    and is always willing to help others despite his heavy workload.  When Xavier leaves on
    vacation, everyone wishes he didn't have to go

    Last year, the only concerns with Xavier performance were around ownership.  In the past
    twelve months, he has successfully taken full ownership of both Acme and Bricks, Inc.
    Aside from some false starts with estimates on Acme, clients are happy with his work and
    responsiveness, which is everything that his managers could ask for."
  end

  def positive_review_two
    "Wanda has been an incredibly consistent and effective developer.  Clients
    are always satisfied with her work, developers are impressed with her productivity, and
    she's more than willing to help others even when she has a substantial workload of her own.
    She is a great asset to Awesome Company, and everyone enjoys working with her.  During the
    past year, she has largely been devoted to work with the Cement Company, and she is the
    perfect woman for the job.  We know that work on a single project can become monotonous,
    however, so over the next few months, we hope to spread some of the Cement Company work to
    others.  This will also allow Wanda to pair more with others and spread her effectiveness
    to other projects."
  end

end
