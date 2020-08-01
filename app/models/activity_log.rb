class ActivityLog < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :task, optional: true
  belongs_to :list, optional: true
  belongs_to :period, optional: true
  belongs_to :invoice, optional: true

  def message(current_user)
    "#{user == current_user ? "You" : current_user.first_name} #{action}"
  end
end
