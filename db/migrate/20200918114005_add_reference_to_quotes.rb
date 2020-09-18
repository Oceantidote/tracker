class AddReferenceToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :quotes, :list, null: false, foreign_key: true
  end
end
