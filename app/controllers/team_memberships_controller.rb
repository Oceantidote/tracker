class TeamMembershipsController < ApplicationController
  before_action :set_team_membership, only: [:destroy]
  def create
    @team_membership = TeamMembership.new(team_membership_params)
    @team_membership.project = Project.find(params[:project_id])
    authorize @team_membership
    deal_with_email
    if @team_membership.save
      redirect_to project_team_memberships_path(@team_membership.project)
      flash[:notice] = "An email has been sent to #{team_membership_params[:email]}, they will be added to the team once they have set up ther Tracker acoount" if team_membership_params[:email]
    else
      redirect_to project_team_memberships_path(@team_membership.project)
      flash[:notice] = "Please choose a developer, or invite someone using their email"
    end
  end

  def destroy
    @project = @team_membership.project
    @team_membership.destroy
    redirect_to project_team_memberships_path(@project)
  end

  private

  def deal_with_email
    if team_membership_params[:email]
      user = User.find_by(email: team_membership_params[:email])
      if user
        @team_membership.user = user
      else
        @user = User.new(email: team_membership_params[:email], password: ('0'..'z').to_a.shuffle[0,8].join)
        @user.save(validate: false)
        # ApplicationMailer.with(user_id: @user.id).invite.deliver_later if @user.email
        @team_membership.user = @user
      end
    elsif team_membership_params[:user_id].present?
      @team_membership.user = User.find(team_membership_params[:user_id])
    end
  end

  def set_team_membership
    @team_membership = TeamMembership.find(params[:id])
    authorize @team_membership
  end

  def team_membership_params
    params.require(:team_membership).permit(:user_id, :email)
  end
end
