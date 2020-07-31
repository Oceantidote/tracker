class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @projects = Project.includes(:tasks, :lists, :periods).where(user: current_user, archived: false)
    @invoices = Invoice.where(user: current_user)
  end

  def developer
    @invoices = Invoice.all
    @periods = Period.where(end_time: nil)
    @projects = Project.includes(:tasks, :lists, :periods).where(archived: false)
  end
end
