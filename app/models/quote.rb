class Quote < ApplicationRecord
  has_many :tasks
  has_many :notes, as: :noteable, dependent: :destroy
  belongs_to :list
  has_rich_text :description
  validates :name, presence: true

  def color
    case self.status
    when "pending"
      "orange"
    when "rejected"
      "red"
    when "accepted"
      "green"
    when "awaiting acceptance"
      "orange"
    end
  end
end
