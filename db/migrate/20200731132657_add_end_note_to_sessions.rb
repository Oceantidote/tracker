class AddEndNoteToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :end_note, :string
  end
end
