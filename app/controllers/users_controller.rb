class UsersController < ApplicationController

  expose(:user, attributes: :user_params)

  def create
    if user.save
      session[:user_id] = user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
