class ChangeQuoteReferenceOnTasks < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tasks, :quote
    add_reference :tasks, :quote, null: true
  end
end
