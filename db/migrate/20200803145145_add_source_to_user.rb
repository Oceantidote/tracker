class AddSourceToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :source, :string
  end
end
