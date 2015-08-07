class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    @user.reset_password! if @user
    reset_session
    flash[:notice] = "Your password has been reset. Please follow the " \
                     "instructions in the email we sent you."
    redirect_to login_path
  end

  def edit
    unless params[:token] && @user = User.find_by(password_reset_token: params[:token])
      redirect_to login_path
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    if @user && @user.update(
        password: params[:password],
        password_confirmation: params[:password_confirmation])
      @user.update(inactive: false)
      flash[:notice] = "You may now log in with your new password."
      redirect_to login_path
    else
      render 'edit'
    end
  end

end
