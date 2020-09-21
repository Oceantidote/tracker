class Chatroom < ApplicationRecord
  belongs_to :project, optional: true
  has_many :messages
end
