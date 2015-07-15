class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to 'dashboard'
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  private
  def user_params
     params.require(:user).permit(
      :username, :email, :avatar, :password, :password_confirmation, :phone,
      :school_id
     )
  end
end
