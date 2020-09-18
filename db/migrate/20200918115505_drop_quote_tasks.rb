class DropQuoteTasks < ActiveRecord::Migration[6.0]
  def change
    drop_table :quote_tasks
  end
end
