class AddRejectedReasonToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :rejected_reason, :string, default: nil
  end
end
