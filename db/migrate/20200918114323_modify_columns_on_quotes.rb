class ModifyColumnsOnQuotes < ActiveRecord::Migration[6.0]
  def change
    remove_column :quotes, :status
    add_column :quotes, :status, :string, default: "pending"
  end
end
