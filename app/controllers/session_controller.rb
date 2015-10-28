class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    @user ||= User.find_by_email(params[:session][:username])
    if @user && @user.inactive
      flash.now[:notice] = "Your password has been reset. Please follow the link" \
                           " in the email we sent you to set a new password."
      render "login"
    elsif @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if session[:redirect_url]
        redirect_to session[:redirect_url]
      else
        redirect_to home_path
      end
    else
      flash.now[:error] = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
