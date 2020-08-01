class Invoice < ApplicationRecord
  belongs_to :project
  has_many :tasks
  has_many :periods, through: :tasks
  def color
    if due_by < 7.day.ago
      "redbg"
    elsif due_by < Time.now
      "yellowbg"
    else
      "greenbg"
    end
  end
end
