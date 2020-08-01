class List < ApplicationRecord
  belongs_to :project
  has_many :tasks
  has_many :periods, through: :tasks

  def incomplete_tasks
    tasks.where(completed: false)
  end

end
