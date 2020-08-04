class AddFaultyToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :faulty, :boolean, default: false
  end
end
