class AddPaymentTypeToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :payment_type, :string
  end
end
