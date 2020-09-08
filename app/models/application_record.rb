class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def readable_length(minutes)
    days = minutes / 1440
    remaining_hours = minutes % 1440
    hours = remaining_hours / 60
    remaining_mins = remaining_hours % 60
    days_text = days > 0 ? "#{days}d " : ""
    hours_text = hours > 0 ? "#{hours}h " : ""
    mins_text = remaining_mins > 0 ? "#{remaining_mins}m" : ""
    days_text + hours_text + mins_text
  end

  def humanized_total(cents)
    rev_string = cents.to_s.reverse
    pennies = rev_string[0..1]&.reverse || '00'
    pounds = rev_string[2..5]&.reverse || '0'
    thousands = rev_string[6..-1]&.reverse
    "£ #{thousands + ',' if thousands}#{pounds}.#{pennies}"
  end
end
