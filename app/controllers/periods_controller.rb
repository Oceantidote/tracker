class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :update, :edit, :destroy]

  def show
  end

  def create
    @period = Period.new(nested_period_params)
    @period.user = current_user
    @period.task_id = params[:task_id].to_i
    if @period.save
      Period.where.not(id: @period.id).where(user: current_user, end_time: nil).update_all(end_time: Time.now)
      redirect_to period_path(@period)
      flash[:notice] = "Nice! The time is you started work on #{ @period.task.name + Time.now.strftime("%I:%M %a")}"
    else
      raise
    end
  end

  def update
    time_params = period_params
    if !time_params[:end_time]
      time_params[:end_time] = Time.now
    end
    @period.update(time_params)
    if @period.save
      redirect_to :root
    else
      render :show
      flash[:notice] = @period.errors
    end
  end

  def finish
  end

  private

  def nested_period_params
    params.require(:period).permit(:end_note, :title, :description, :end_time)
  end

  def period_params
    params.permit(:task, :end_note, :title, :description, :end_time)
  end

  def set_period
    @period = Period.find(params[:id])
  end

end
