class List < ApplicationRecord
  belongs_to :project
  has_many :tasks
  has_many :periods, through: :tasks
  validates :name, presence: true
  validates :payment_type, presence: true

  PAYMENT_TYPES = {
    "emergency" => "Emergency 🚨 -> If your site has gone down or something is breaking add it here. Your team will be notified immediately and the task will go to the top of their priority list. If we were the cause of the error the tasks will be free, if not the task will be billed hourly upon completion.",
    "quoted" => "Priced 💷 -> New tasks will be quoted at a fixed price by the development team. If the quote is accepted by the project owner the task will be billed upon completion. Best for large features and major changes.",
    "support" => "Hourly ⏱️ -> Tasks will be started immediately and billed at an hourly rate. Best for small changes to the site and stuff you want done fast.",
    "free" => "Free 🆓 -> Tasks will not be charged, so best to add the jobs that don't require development here."
  }

  def incomplete_tasks
    tasks.where(completed: false)
  end

  def type_emoji
    case payment_type
    when 'quoted'
      '🤝'
    when 'support'
      '⏱️'
    when 'free'
      '🆓'
    end
  end

  def type_info
    PAYMENT_TYPES[payment_type]
  end

end
