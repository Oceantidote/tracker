class Task < ApplicationRecord
  belongs_to :list
  has_many :periods
  before_save :set_approved
  def set_approved
    list.payment_type == "qouted" ? false : true
  end
end
