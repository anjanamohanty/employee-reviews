# Employee Reviews

This code allows you to create a department and add employees to it (with a name, email address, phone number and salary). You can then use it to give an employee a review, give them a raise and give raises across an entire department.

## Getting started

To integrate this in your own program, add ```department.rb``` and ```employee.rb``` in your project directory, and:

```ruby
require './department.rb'
```

## Creating employees and departments

Create a new department:
```ruby
computer_science = Department.new("Computer Science")
```

Create new employees:
```ruby
bob = Employee.new("Bob", "bob@email.com", "919-555-5555", 100000)
carl = Employee.new("Carl", "carl@email.com", "919-777-7777", 60000)
```

Add employees to a department:
```ruby
computer_science.add_employee(bob)
computer_science.add_employee(carl)
```

## Submitting reviews for employees
```ruby
review_text = "Aliqua fap tousled distillery, scenester reprehenderit poutine
brunch mustache vinyl williamsburg listicle yr post-ironic put a bird on it.
Hoodie kombucha waistcoat, nesciunt franzen esse velit pitchfork cronut.
Wolf salvia gluten-free nisi, assumenda ramps four loko butcher raw denim narwhal
ennui veniam pabst. Adipisicing helvetica reprehenderit, nulla tattooed keytar."
bob.add_review(review_text)
```
> Once a review is given for an employee their rating is automatically set as satisfactory or unsatisfactory, based on the review that was given

## Giving raises based on performance
```ruby
raise_amount = 5000

d.give_raises(each: raise_amount) do |employee|
  employee.is_satisfactory?
end

# Gives a $5,000 raise to all employees in the department with a satisfactory job rating.
```

## Giving raises based on current salary
```ruby
raise_amount = 5000

d.give_raises(each: raise_amount) do |employee|
  employee.salary < 100000
end

# Gives a $5,000 raise to all employees in the department who make less that $100,000.
```
