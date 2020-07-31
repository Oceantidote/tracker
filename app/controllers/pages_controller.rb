class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @projects = Project.includes(:tasks, :lists, :sessions).where(user: current_user, archived: false)
    @invoices = Invoice.where(user: current_user)
  end

  def developer
    @invoices = Invoice.all
    @session = Session.where(end_time: nil)
    @projects = Project.includes(:tasks, :lists, :sessions).where(archived: false)
  end
end
