class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    @user ||= User.find_by(email: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      session[:is_parent?] = false
      client_redirect "/dashboard"
    elsif @user && BCrypt::Password.new(@user.parent_password) == params[:user][:password]
        session[:user_id] = @user.id
        session[:is_parent?] = true
        client_redirect "/dashboard"
    else
      flash[:notice] = "Invalid username or password"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  def store_user_commitment
   if params[:commitment]
      session[:commitment] = params[:commitment]
      flash[:redirect_url] = "/events/#{params[:id]}/attendances/new"
      redirect_to "/redirect"
    else
      flash[:redirect_url] = "/events/#{params[:id]}"
      redirect_to "/redirect"
    end
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
