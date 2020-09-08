class AddIssuedAtToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :issued_at, :datetime
  end
end
