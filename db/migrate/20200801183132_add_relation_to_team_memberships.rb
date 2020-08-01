class AddRelationToTeamMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :team_memberships, :relation, :string
  end
end
