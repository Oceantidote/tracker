class AddLengthToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :length, :integer
  end
end
