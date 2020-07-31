class AddArchivedToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :archived, :boolean, default: false
  end
end
