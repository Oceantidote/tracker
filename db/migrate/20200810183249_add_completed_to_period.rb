class AddCompletedToPeriod < ActiveRecord::Migration[6.0]
  def change
    add_column :periods, :completed, :boolean, default: false
  end
end
