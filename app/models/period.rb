class Period < ApplicationRecord
  belongs_to :user
  belongs_to :task
  validates :title, presence: true

  def length
    if end_time.nil?
      elapsed = (Time.now - created_at) / 60.to_f
    else
      elapsed = (end_time - created_at) / 60.to_f
    end
    (elapsed / 5).ceil * 1
  end

  def total
    if task.list.payment_type == "support"
      length * 66
    else
      0
    end
  end

  def humanized_total
    rev_string = total.to_s.reverse
    pennies = rev_string[0..1]&.reverse
    pounds = rev_string[2..5]&.reverse
    thousands = rev_string[6..-1]&.reverse
    "£ #{thousands + ',' if thousands}#{pounds}.#{pennies}"
  end
end
