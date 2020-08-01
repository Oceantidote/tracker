class AddPaidAtToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :paid_at, :datetime
  end
end
