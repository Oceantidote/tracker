class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :project
  def pretty_relation
    case relation
    when "lead"
      "Lead developer"
    when "client"
      "Project owner"
    else
      "Developer"
    end
  end
end
