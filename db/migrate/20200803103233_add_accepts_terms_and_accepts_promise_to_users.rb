class AddAcceptsTermsAndAcceptsPromiseToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :accepts_terms, :boolean, default: false
    add_column :users, :accepts_promise, :boolean, default: false
  end
end
