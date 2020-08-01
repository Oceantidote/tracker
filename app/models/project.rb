class Project < ApplicationRecord
  belongs_to :user
  belongs_to :dev_user, :class_name => 'User'
  has_many :lists
  has_many :tasks, through: :lists
  has_many :periods, through: :tasks
  has_many :invoices
  has_many :team_memberships
  has_many :members, through: :team_memberships, source: :user

  def paid_invoices
    invoices.order(due_by: :asc).where.not(paid_at: nil)
  end

  def unpaid_invoices
    invoices.order(due_by: :asc).where(paid_at: nil)
  end

  def live_periods
    periods.where(end_time: nil)
  end
end
