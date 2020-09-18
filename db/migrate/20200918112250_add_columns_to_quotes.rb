class AddColumnsToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :name, :string
  end
end
