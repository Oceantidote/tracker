class RemoveUserReferenceFromQuotes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :quotes, :user
  end
end
