class Employee

  attr_reader :name, :salary

  def initialize(name, email, phone_number, salary)
    @name = name
    @email = email
    @phone = phone_number
    @salary = salary
  end

  def add_review(review)
    @review = review
  end

  def get_review
    @review 
  end

end
