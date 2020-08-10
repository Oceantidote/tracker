class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :position, :last_name, :photo, :company_logo, :email, :company, :accepts_terms, :accepts_promise)
  end

end
