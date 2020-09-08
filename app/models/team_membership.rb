class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :project
  before_save :set_priority

  def pretty_relation
    case relation
    when "client"
      "Project owner"
    when "lead"
      "Lead developer"
    else
      "Developer"
    end
  end

  def set_priority
    case relation
    when "client"
      self.priority = 1
    when "lead"
      self.priority = 2
    else
      self.priority = 3
    end
  end
end
