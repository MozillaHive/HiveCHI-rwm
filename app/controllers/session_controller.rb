class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    # if @user && @user.authenticate(params[:user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      @errors = ["Invalid email or password"]
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end

  def store_user_commitment
    session[commitment: "#{params[:commitment]}"]
    redirect_to "/events/#{params[:id]}/attendances/new"
  end

  def store_user_time_preference
    session[time_preference: "#{params[:time_preference]}"]
    redirect_to "/events"
  end

  private
    def user_params
     params.require(:user).permit(:email, :password)
    end
end
