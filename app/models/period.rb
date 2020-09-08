class Period < ApplicationRecord
  belongs_to :task
  belongs_to :user
  belongs_to :user, :class_name => 'User'
  validates :title, presence: true
  before_update :set_length!
  before_update :set_price!

  def set_length!
    self.length = current_length
  end

  def current_length
    if end_time.nil?
      elapsed = (Time.now - created_at) / 60.to_f
    else
      elapsed = (end_time - created_at) / 60.to_f
    end
    elapsed.ceil
  end

  def total
    if task.list.payment_type == "support"
      ((current_length * user.hourly_rate / 60.0) * 100).to_i
    elsif task.list.payment_type == "emergency"
      ((current_length * user.hourly_rate / 60.0) * 120).to_i
    elsif task.list.payment_type == "quoted"
      if task.completed == true
        current_length / task.total_length * task.price
      else
        0
      end
    else
      0
    end
  end

  def set_price!
    self.price = total
  end

  def humanized_total
    rev_string = total.to_s.reverse
    pennies = rev_string[0..1]&.reverse
    pounds = rev_string[2..5]&.reverse
    thousands = rev_string[6..-1]&.reverse
    "£ #{thousands + ',' if thousands}#{pounds}.#{pennies}"
  end
end
