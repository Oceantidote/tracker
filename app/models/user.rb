class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
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
  def my_pending_invoices
    invoices.where(approved: false)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def cap_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
