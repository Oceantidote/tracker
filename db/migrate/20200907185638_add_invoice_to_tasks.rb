class AddInvoiceToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :invoice, null: true, foreign_key: true
  end
end
