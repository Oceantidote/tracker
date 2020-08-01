class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :update, :edit, :destroy]
  def show
  end

  private

  def set_period
    @period = Period.find(params[:id])
  end

end
