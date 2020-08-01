class AddDueByToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :due_by, :datetime, default: 1.week.from_now
  end
end
