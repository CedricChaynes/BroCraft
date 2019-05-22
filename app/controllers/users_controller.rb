class UsersController < ApplicationController
  skip_after_action :verify_authorized

  def my_profile
  end

  def update
    current_user.update!(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:username, :mobile, :address)
  end
end
