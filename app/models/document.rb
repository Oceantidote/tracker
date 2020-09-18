class Document < ApplicationRecord
  belongs_to :project
  has_one_attached :file
  has_many :notes, as: :noteable
end
