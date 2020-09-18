class Project < ApplicationRecord
  belongs_to :user
  belongs_to :dev_user, :class_name => "User"
  has_many :lists, dependent: :destroy
  has_many :tasks, through: :lists
  has_many :periods, through: :tasks
  has_many :invoices, dependent: :destroy
  has_many :team_memberships,  dependent: :destroy
  has_many :members, through: :team_memberships, source: :user
  validates :name, presence: true
  after_create :create_lists

  def current_invoice
    self.invoices.order(created_at: :desc).first
  end

  def week_passes
    if self.current_invoice.tasks.any?
      self.current_invoice.update(approved: false, issued_at: Time.now)
      Invoice.create!(project: self, approved: nil, total: calculate_total)
    end
  end

  def calculate_total
    self.tasks.sum(&:total)
  end

  def deleteable_memberships
    team_memberships.where("priority > 2")
  end

  def valid_memberships
    team_memberships.select{|m| m.user.valid?}
  end

  def valid_members
    members.select{|m| m.valid?}
  end

  def paid_invoices
    invoices.order(due_by: :asc).where.not(paid_at: nil)
  end

  def unpaid_invoices
    invoices.order(due_by: :asc).where(paid_at: nil, issued_at: nil, approved: true)
  end

  def live_periods
    periods.where(end_time: nil)
  end

  def self.payment_types
    [
      ["emergency", "Emergency 🚨 -> If your site has gone down or something is breaking add it here. Your team will
       be notified immediately and the task will go to the top of their priority list."],
      ["quoted", "Quoted 🤝 -> New tasks will be quoted at a fixed price by the development team. If the quote is accepted
       by the project owner the task will be billed upon completion. Best for large features and major changes."],
      ["support", "Hourly ⏱️ -> Tasks will be started as soon as possible and billed at an hourly rate. Best for small changes to
       the site and stuff you want done fast."],
      ["my tasks", "My Tasks 🆓 -> This is a good list type to use for your own tasks or when you are testing out the platform for the first time."]
    ]
  end

  def week_passes

  end

  private

  def create_lists
    List.create!(name: "Emergencies", payment_type: "emergency", project: self)
    List.create!(name: "Support", payment_type: "support", project: self)
    List.create!(name: "Quoted", payment_type: "quoted", project: self)
    List.create!(name: "My tasks", payment_type: "my_tasks", project: self)
  end
end
