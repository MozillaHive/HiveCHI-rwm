class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :client_redirect, :current_user, :home_path, :edit_profile_path,
    :current_student, :current_parent, :current_service_provider

  def require_login
    if current_user.nil?
      redirect_to login_path
    elsif current_user.inactive
      redirect_inactive_user
    end
  end

  def require_no_login
    redirect_to home_path unless current_user.nil?
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

  def require_service_provider
    unless current_user && current_user.service_provider?
      redirect_to root_path
    end
  end

  def require_student
    unless current_user && current_user.student?
      redirect_to root_path
    end
  end

  def require_registration_enabled
    if ENV["DISABLE_REGISTRATIONS"] == "TRUE"
      flash[:notice] = "We're sorry, but registration is temporarily disabled."
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_student
    (current_user && current_user.student?) ? current_user.role : nil
  end

  def current_service_provider
    (current_user && current_user.service_provider?) ? current_user.role : nil
  end

  def current_parent
    (current_user && current_user.parent?) ? current_user.role : nil
  end

  def client_redirect (redirect_url)
		flash[:redirect_url] = redirect_url
  	redirect_to "/redirect"
  end

  def home_path
    case current_user.role_type
    when "Student" then dashboard_path
    when "ServiceProvider" then service_provider_root_path
    when "Admin" then rails_admin_path
    end
  end

  def edit_profile_path
    case current_user.role_type
    when "Student" then edit_student_path
    when "Parent" then edit_parent_path
    when "ServiceProvider" then edit_service_provider_path
    end
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
