class AddFaultyToPeriod < ActiveRecord::Migration[6.0]
  def change
    add_column :periods, :faulty, :boolean, default: false
  end
end
