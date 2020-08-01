class Period < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def length
    if end_time.nil?
      elapsed = (Time.now - created_at) / 60.to_f
    else
      elapsed = (end_time - created_at) / 60.to_f
    end
    (elapsed / 5).ceil * 5
  end

  def readable_length
    days = length / 1440
    remaining_hours = length % 1440
    hours = remaining_hours / 60
    remaining_mins = remaining_hours % 60
    days_text = days > 0 ? "#{days} days " : ""
    hours_text = hours > 0 ? "#{hours} hrs " : ""
    mins_text = remaining_mins > 0 ? "#{remaining_mins} mins" : ""
    days_text + hours_text + mins_text
  end

  def total
    if task.list.payment_type == "support"
      length * 66
    end
  end

  def humanized_total
    rev_string = total.to_s.reverse
    pennies = rev_string[0..1].reverse
    pounds = rev_string[2..5].reverse
    thousands = rev_string[6..-1]&.reverse
    "£ #{thousands + ',' if thousands}#{pounds}.#{pennies}"
  end
end
