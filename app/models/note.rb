class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true
  belongs_to :user
  has_rich_text :content
end
