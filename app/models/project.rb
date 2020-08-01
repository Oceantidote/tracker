class Project < ApplicationRecord
  belongs_to :user
  belongs_to :dev_user, :class_name => 'User'
  has_many :lists
  has_many :tasks, through: :lists
  has_many :periods, through: :tasks
  has_many :invoices
  has_many :team_memberships
  has_many :members, through: :team_memberships, source: :user
end
