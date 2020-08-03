class Project < ApplicationRecord
  belongs_to :user
  belongs_to :dev_user, :class_name => "User"
  has_many :lists
  has_many :tasks, through: :lists
  has_many :periods, through: :tasks
  has_many :invoices
  has_many :team_memberships
  has_many :members, through: :team_memberships, source: :user
  after_create :create_lists

  def paid_invoices
    invoices.order(due_by: :asc).where.not(paid_at: nil)
  end

  def unpaid_invoices
    invoices.order(due_by: :asc).where(paid_at: nil)
  end

  def live_periods
    periods.where(end_time: nil)
  end

  def create_lists
    List.create!(name: "Emergencies", payment_type: "emergency", project: self)
    List.create!(name: "Support", payment_type: "support", project: self)
    List.create!(name: "Quoted", payment_type: "quoted", project: self)
    List.create!(name: "Free", payment_type: "free", project: self)
  end


  def self.payment_types
    [
      ["emergency", "Emergency 🚨 -> If your site has gone down or something is breaking add it here. Your team will
       be notified immediately and the task will go to the top of their priority list. If we were the cause of the error
        the tasks will be free, if not the task will be billed hourly upon completion."],
      ["quoted", "Quoted 🤝 -> New tasks will be quoted at a fixed price by the development team. If the quote is accepted
       by the project owner the task will be billed upon completion. Best for large features and major changes."],
      ["support", "Hourly ⏱️ -> Tasks will be started as soon as possible and billed at an hourly rate. Best for small changes to
       the site and stuff you want done fast."],
      ["free", "Free 🆓 -> Tasks will not be charged, so best to add the jobs that don't require development here."]
    ]
  end
end
