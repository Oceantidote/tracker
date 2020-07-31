class AddPriceToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :price, :integer
  end
end
