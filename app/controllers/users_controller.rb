class UsersController < ApplicationController
  skip_after_action :verify_authorized

  def my_profile
  end

  def update
    p user_params
    current_user.update!(user_params)
  end

  private


  def user_params
    params.require(:user).permit(:username)
  end
end
