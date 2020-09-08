class Invoice < ApplicationRecord
  belongs_to :project
  has_many :tasks
  has_many :periods, through: :tasks

  def color
    if due_by < 7.day.ago
      "redbg"
    elsif due_by < Time.now
      "yellowbg"
    elsif due_by > Time.now && due_by < 1.day.from_now
      "greenbg"
    else
      ""
    end
  end

  def approve
    self.update(approved: true)
  end
end
