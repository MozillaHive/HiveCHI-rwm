class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    redirect_to "/login" unless session[:user_id]
  end

  helper_method :current_user
  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :client_redirect
  def client_redirect (redirect_url)
  		flash[:redirect_url] = redirect_url
    	redirect_to "/redirect"
  end

end
