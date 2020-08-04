class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @projects = current_user.member_projects
    @invoices = current_user.invoices
    @tasks = current_user.tasks.where("completed_by < ?", 3.day.from_now)
    @quotes = current_user.quotes
    @periods = current_user.periods.where.not(end_time: nil)
  end

  def developer
    @admin_users = User.where(admin: true)
    redirect_to period_path(@current_period) if @current_period
    @assigned_tasks = current_user.assigned_tasks
    @due_tasks = current_user.member_tasks.order(completed_by: :asc)
    @dev_periods = current_user.periods
    @my_invoices = current_user.dev_invoices
  end

  def profile
    @activity_logs = ActivityLog.where(user: current_user).where("created_at > ?", 48.hour.ago)
  end
end
