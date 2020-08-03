class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @projects = current_user.visible_projects
    @invoices = current_user.invoices
    @tasks = current_user.tasks.where("completed_by < ?", 3.day.from_now)
    @quotes = current_user.quotes
    @periods = current_user.periods.where.not(end_time: nil)
  end

  def developer
    @periods = Period.where(end_time: nil, user: current_user)
    if @periods.any?
      redirect_to period_path(@periods.first)
    end
    @tasks = current_user.tasks
    @due_tasks = Task.where("completed_by < ?", 3.day.from_now)
    @invoices = Invoice.all
    @my_invoices = current_user.my_pending_invoices
    @projects = Project.includes(:tasks, :lists, :periods).where(archived: false)
  end

  def profile
    @activity_logs = ActivityLog.where(user: current_user).where("created_at > ?", 48.hour.ago)
  end
end
