class AddPriorityToTeamMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :team_memberships, :priority, :integer
  end
end
