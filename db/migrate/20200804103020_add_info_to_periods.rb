class AddInfoToPeriods < ActiveRecord::Migration[6.0]
  def change
    add_column :periods, :length, :integer, default: 0
  end
end
