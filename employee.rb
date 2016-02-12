class Employee

  attr_reader :name, :review, :score

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

    bad_re = /(not|concern|bug|long|bad|improve|issue|needs)\b/i
    good_re = /(happy|excellent|consistent|enjoy|productive|asset|effective|positive)\b/i

    @score = @review.scan(good_re).length.to_f / @review.scan(bad_re).length
  end

  def get_review
    @review
  end

  def give_raise!(percentage: nil, amount: nil)
    @salary = @salary * (1 + percentage) if percentage
    @salary = @salary + amount if amount
  end

  def is_satisfactory?
    return true if @score == nil
    @score > 1 ? true : false
  end

end
