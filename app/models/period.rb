class Period < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def length
    return if end_time.nil?

    elapsed = (end_time - created_at) / 60.to_f
    (elapsed / 5).ceil * 5
  end
end
