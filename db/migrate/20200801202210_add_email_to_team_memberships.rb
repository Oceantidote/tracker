class AddEmailToTeamMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :team_memberships, :email, :string
  end
end
