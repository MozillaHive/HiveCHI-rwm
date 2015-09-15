class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = find_user_by_username(params[:session][:username])
    @user ||= User.find_by(email: params[:session][:username])
    if @user && @user.inactive
      flash.now[:notice] = "Your password has been reset. Please follow the link" \
                           " in the email we sent you to set a new password."
      render "login"
    elsif @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if session[:redirect_url]
        redirect_to session[:redirect_url]
      else
        redirect_to dashboard_path
      end
    else
      flash.now[:error] = "Invalid username or password"
      render "login"
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private
    def user_params
     params.require(:user).permit(:email, :password)
    end

    def find_user_by_username(username)
      if (student = Student.find_by(username: username))
        student.user
      else
        nil
      end
    end
end
