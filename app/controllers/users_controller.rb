class UsersController < ApplicationController
  before_filter :require_login, except: :new

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

  def verification
    @user = current_user
    redirect_to "dashboard" if @user.verified?
  end

  def verify
    @user = current_user
    @user.verify_email!(params[:email_token]) if params[:email_token]
    @user.verify_phone!(params[:phone_token]) if params[:phone_token]
    if @user.verified?
      redirect_to "dashboard"
    else
      @errors = @user.errors.full_messages
      render "verification"
    end
  end

  private
  def user_params
     params.require(:user).permit(
      :username, :email, :password, :password_confirmation, :phone,
      :school_id
     )
  end
end
