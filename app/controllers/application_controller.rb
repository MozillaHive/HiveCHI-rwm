class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
<<<<<<< HEAD
end
=======
  helper_method :current_user
  def current_user
      @current_user ||= User.find_by_id(session[:user])
  end
end
>>>>>>> f7d09b956e8bf04d2fb90f972ef1b67ba0cfe50e
