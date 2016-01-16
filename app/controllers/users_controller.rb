class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :verify_email, :tos]
  before_filter :require_no_login, only: :new
  before_filter :require_registration_enabled, only: :new

  def new
    @user = User.new
  end

  def verification
    @user = current_user
    redirect_to home_path if @user.verified?
    unless @user.email_verified
      flash[:errors] ||= []
      msg = "Your email address has not been verified. Please " \
                        "click on the link in the confirmation email we sent" \
                        " you."
      flash[:errors] << msg unless flash[:errors].include? msg
    end
  end

  def verify_email
    if params[:token] && @user = User.find_by(email_token: params[:token])
      @user.verify_email!(params[:token])
      reset_session
      session[:user_id] = @user.id
      redirect_to users_verify_path
    else
      redirect_to root_path
    end
  end

  def verify
    @user = current_user
    @user.verify_email!(params[:email_token]) if params[:email_token]
    @user.verify_phone!(params[:phone_token]) if params[:phone_token]
    if @user.verified?
      if session[:redirect_url]
        url  = session[:redirect_url]
        session[:redirect_url] = nil
        redirect_to url
      else
        redirect_to dashboard_path
      end
    else
      render "verification"
    end
  end

  def resend_confirmation_email
    unless current_user.email_verified?
      current_user.send_verification_email
      flash[:errors] ||= []
      flash[:errors] << "Your verification email has been sent. It may take a few minutes to arrive. Please " \
                        "click on the link in the confirmation email we sent" \
                        " you."
    end
    redirect_to method: :verify
  end

  def tos
  end

  private

  def user_params
     params.require(:user).permit(
      :username, :email, :password, :password_confirmation, :phone, :school_id,
      :parent_password, :parent_password_confirmation, :nudges_enabled, :time_zone
     )
  end

end
