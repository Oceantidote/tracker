class AddDevUserToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :dev_user
    # Rails 5+ only: add foreign keys
    add_foreign_key :projects, :users, column: :dev_user_id, primary_key: :id
  end
end
