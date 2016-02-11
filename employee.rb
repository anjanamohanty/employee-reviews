class Employee

  attr_reader :name, :performance, :review

  def initialize(name, email, phone_number, salary)
    @name = name
    @email = email
    @phone = phone_number
    @salary = salary
  end

  def salary
    @salary.to_f.round(2)
  end

  def add_review(review)
    @review = review
  end

  def get_review
    @review
  end

  def mark_performance(symbol)
    @performance = symbol
  end

  def give_raise!(percentage: nil, amount: nil)
    @salary = @salary * (1 + percentage) if percentage
    @salary = @salary + amount if amount
  end

  def is_satisfactory?
    bad_re = /(not|concern|bug|long|bad|improve|issue)/i
    good_re = /(happy|enjoy|productive|asset|effective)/i

    @satisfactory = @review.scan(good_re).length > @review.scan(bad_re).length
  end

end
