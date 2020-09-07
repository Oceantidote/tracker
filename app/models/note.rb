class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true
  belongs_to :user
  has_rich_text :content
end



class User
  has_many :member_projects, through: :bookings, source: :project

  def member_projects
    self.bookings.map{|b| b.project}
  end
end
