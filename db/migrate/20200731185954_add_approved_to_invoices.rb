class AddApprovedToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :approved, :boolean, default: false
  end
end
