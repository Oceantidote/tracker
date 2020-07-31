class Project < ApplicationRecord
  belongs_to :user
  has_many :lists
  has_many :tasks, through: :lists
  has_many :periods, through: :tasks
end
