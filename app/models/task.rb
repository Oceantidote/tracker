class Task < ApplicationRecord
  belongs_to :list
  has_many :periods
end
