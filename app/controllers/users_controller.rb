class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create, :verify_email]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/users/verify'
    else
      flash[:reg_errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def verification
    @user = current_user
    redirect_to "/dashboard" if @user.verified?
    unless @user.email_verified
      flash[:errors] ||= []
      flash[:errors] << "Your email address has not been verified. Please " \
                        "click on the link in the confirmation email we sent" \
                        " you."
    end
  end

  def verify_email
    if params[:token] && @user = User.find_by(email_token: params[:token])
      @user.verify_email!(params[:token])
      reset_session
      session[:user_id] = @user.id
      redirect_to "/users/verify"
    else
      redirect_to "/"
    end
  end

  def verify
    @user = current_user
    @user.verify_email!(params[:email_token]) if params[:email_token]
    @user.verify_phone!(params[:phone_token]) if params[:phone_token]
    if @user.verified?
      redirect_to "/dashboard"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/verify"
    end
  end

  private
  def user_params
     params.require(:user).permit(
      :username, :email, :password, :password_confirmation, :phone, :school_id
     )
  end
end
