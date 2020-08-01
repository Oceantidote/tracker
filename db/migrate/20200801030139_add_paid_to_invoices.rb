class AddPaidToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :paid, :boolean, default:false
  end
end
