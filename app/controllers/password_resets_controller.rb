class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    flash[:notice] = "Your password has been reset. Please follow the " \
                     "instructions in the email we sent you."
    @user.reset_password! if @user
    redirect_to login_path
  end

end
