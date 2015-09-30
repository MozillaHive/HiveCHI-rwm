class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    if current_user.nil?
      redirect_to login_path
    elsif current_user.inactive
      redirect_inactive_user
    end
  end

  def require_verified_user
    if current_user.nil?
      redirect_to login_path
    elsif current_user.inactive
      redirect_inactive_user
    elsif !current_user.verified?
      redirect_to users_verify_path
    end
  end

  helper_method :current_user
  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_student
    if current_user.student?
      current_user.role
    else
      raise TypeError, "Current user is not a student"
    end
  end

  def current_service_provider
    if current_user.service_provider?
      current_user.role
    else
      raise TypeError, "Current user is not a service provider"
    end
  end

  helper_method :client_redirect
  def client_redirect (redirect_url)
  		flash[:redirect_url] = redirect_url
    	redirect_to "/redirect"
  end

  private

  def redirect_inactive_user
    reset_session
    flash[:notice] = "Your password has been reset. Please follow the " \
                     "instructions in the email we sent you to choose a new " \
                     "password."
    redirect_to login_path
  end

end
