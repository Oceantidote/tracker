class AddApprovedToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :approved, :string
    add_column :tasks, :price, :integer
    add_column :tasks, :completed_by, :datetime
  end
end
