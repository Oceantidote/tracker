class Task < ApplicationRecord
  belongs_to :list
  belongs_to :quote, optional: true
  has_many :periods
  before_save :set_approved
  validates :name, presence: true
  has_many :user_tasks
  has_many :users, through: :user_tasks

  def set_approved
    list.payment_type == "qouted" ? false : true
  end

  def payment_type
    list.payment_type
  end

  def total_length
    sum = 0
    periods.each{|r| sum += r.length}
    sum
  end
end
