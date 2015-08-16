module ApplicationHelper
  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end

  def get_time_zone
    if current_user
      current_user.get_time_zone
    else
      ActiveSupport::TimeZone.new("Central Time (US & Canada)")
    end
  end
end
