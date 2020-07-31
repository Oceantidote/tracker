class Invoice < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :periods, through: :tasks
end
