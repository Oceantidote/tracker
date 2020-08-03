class AddQuoteToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :quote, foreign_key: true
  end
end
