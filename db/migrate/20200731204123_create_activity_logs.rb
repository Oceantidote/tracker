class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: true, foreign_key: true
      t.references :task, null: true, foreign_key: true
      t.references :list, null: true, foreign_key: true
      t.string :action
      t.references :period, null: true, foreign_key: true
      t.references :invoice, null: true, foreign_key: true

      t.timestamps
    end
  end
end
