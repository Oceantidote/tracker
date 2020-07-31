class Invoice < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :sessions, through: :tasks
end
