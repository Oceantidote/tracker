class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :registerable, :validatable
  before_validation :cap_name
  has_many :projects
  has_many :invoices
  has_many :periods, through: :projects
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :dev_projects, :class_name => 'Project', :foreign_key => 'dev_user_id'
  has_many :invoices, through: :dev_projects
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :team_memberships, dependent: :destroy
  has_many :visible_projects, through: :team_memberships, source: :project
  has_one_attached :photo
  has_one_attached :company_logo
  before_create :set_color

  def busy
    Period.where(user: current_user, end_time: nil)
  end

  def set_color
    color = "#" + Random.bytes(3).unpack1('H*')
  end

  def my_pending_invoices
    invoices.where(approved: false)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def initials
    first_name[0].upcase + last_name[0]&.upcase
  end

  def cap_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
