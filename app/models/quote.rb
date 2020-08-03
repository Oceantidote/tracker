class Quote < ApplicationRecord
  has_many :quotes
  belongs_to :user
end
