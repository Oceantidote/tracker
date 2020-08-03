class User < ApplicationRecord

  SOURCES = ["Google","From a friend","Via Le Wagon","From one of our happy customers"]

  devise :database_authenticatable, :recoverable, :rememberable, :registerable, :validatable

  has_many :team_memberships, dependent: :destroy
  has_many :visible_projects, through: :team_memberships, source: :project
  has_many :dev_projects, :class_name => 'Project', :foreign_key => 'dev_user_id'
  has_many :dev_invoices, through: :dev_projects, source: :dev_user
  has_many :projects
  has_many :lists, through: :projects
  has_many :tasks, through: :lists
  has_many :periods, through: :tasks
  has_many :quotes
  has_many :quote_tasks, through: :quotes
  has_many :quoted_tasks, through: :quotes, source: :user
  has_many :invoices, through: :projects, source: :user
  has_many :user_tasks
  has_many :assigned_tasks, through: :user_tasks, source: :user
  has_many :dev_periods, through: :periods, source: :user
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one_attached :photo
  has_one_attached :company_logo

  before_validation :cap_name
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
    company&.capitalize!
  end
end
