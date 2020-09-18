class List < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy
  has_many :periods, through: :tasks
  validates :name, presence: true
  validates :payment_type, presence: true
  has_many :quotes

  PAYMENT_TYPES = {
    "emergency" => "Emergency -> If your site has gone down or something is breaking add it here. Your team will be notified immediately and the task will go to the top of their priority list. If we were the cause of the error the tasks will be free, if not the task will be billed hourly upon completion.",
    "quoted" => "Quoted -> New tasks will be quoted at a fixed price by the development team. If the quote is accepted by the project owner the task will be billed upon completion. Best for large features and major changes.",
    "support" => "Hourly -> Tasks will be started immediately and billed at an hourly rate. Best for small changes to the site and stuff you want done fast.",
    "my_tasks" => "My Tasks -> This is a good list type to use for your own tasks or when you are testing out the platform for the first time."
  }

  def incomplete_tasks
    tasks.where(completed: false)
  end

  def type_emoji
    case payment_type
    when 'emergency'
      '🚨'
    when 'quoted'
      '🤝'
    when 'support'
      '⏱️'
    when 'my_tasks'
      '🆓'
    end
  end

  def support_prompt
    case payment_type
    when 'emergency'
      "If your site has gone down or something is breaking add it here. Your team will be notified immediately and the task will go to the top of their priority list. If our faulty code caused the error the fix will be free. If not these tasks will be billed at 120%\ the developer's hourly rate. If you hold a support contract with us, the time spent fixing the problem will be deducted from your monthly"
    when 'quoted'
      'New tasks will be quoted at a fixed price by the development team. If the quote is accepted by the project owner the task will be billed upon completion. Best for large features and major changes.'
    when 'support'
      'Support asks will be started immediately and billed at an hourly rate. Best for small changes to the site and stuff you want done fast.'
    when 'my_tasks'
      "This is a good list type to use for your own tasks or when you are testing out the platform for the first time."
    end
  end



  def type_info
    PAYMENT_TYPES[payment_type]
  end

end




































