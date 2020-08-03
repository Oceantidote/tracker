class QuoteTask < ApplicationRecord
  belongs_to :quote
  belongs_to :task
end
