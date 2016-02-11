# Employee Reviews

This code allows you to create a department and add employees to it (with a name, email address, phone number and salary). You can then use it to give an employee a review, give them a raise and give raises across an entire department.

## Getting started

To integrate this in your own program, add ```department.rb``` and ```employee.rb``` in your project directory, and:

```ruby
require './department.rb
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
TODO
```

## Giving raises based on performance
```ruby
TODO
```

## Giving raises based on current salary
```ruby
TODO
```



