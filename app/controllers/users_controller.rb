class UsersController < ApplicationController
  skip_after_action :verify_authorized

  def my_profile
  end

  def update
    current_user.update!(user_params)
    redirect_back(fallback_location: my_profile_path)
  end

  private

  def user_params
    params.require(:user).permit(:username, :mobile, :address, :avatar)
  end
end
