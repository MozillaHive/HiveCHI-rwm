module ApplicationHelper
  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end
end
