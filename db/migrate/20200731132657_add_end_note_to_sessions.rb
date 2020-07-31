class AddEndNoteToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :periods, :end_note, :string
  end
end
