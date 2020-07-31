class AddPriceToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :periods, :price, :integer
  end
end
