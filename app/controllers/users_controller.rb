class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_user_dog_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  private
  def user_params
     params.require(:user).permit(:username, :email, :avatar, :password)
  end
end