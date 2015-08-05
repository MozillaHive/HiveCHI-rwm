class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    @user ||= User.find_by(email: params[:user][:username])
    if @user && @user.inactive
      flash.now[:notice] = "Your password has been reset. Please follow the link" \
                           " in the email we sent you to set a new password."
      render "login"
    elsif @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      session[:is_parent?] = false
      if session[:redirect_url]
        flash[:redirect_url] = session[:redirect_url]
        session[:redirect_url] = nil
        redirect_to "/redirect"
      else
        redirect_to dashboard_path
      end
    elsif @user && BCrypt::Password.new(@user.parent_password) == params[:user][:password]
      session[:user_id] = @user.id
      session[:is_parent?] = true
      if session[:redirect_url]
        flash[:redirect_url] = session[:redirect_url]
        session[:redirect_url] = nil
        redirect_to "/redirect"
      else
        client_redirect "/dashboard"
      end
    else
      flash.now[:notice] = "Invalid username or password"
      render "login"
    end
  end

  def destroy
    session.clear
    flash[:redirect_url] = login_path
    redirect_to "/redirect"
  end

  def store_user_time_preference
    #session[time_preference: "#{params[:time_preference]}"]
    redirect_to "/events"
  end

  def redirect
    @url = flash[:redirect_url]
    flash[:notice] = flash[:notice]
  end

  private
    def user_params
     params.require(:user).permit(:email, :password)
    end
end
