module ApplicationHelper
  def get_time_zone
    if current_user
      current_user.get_time_zone
    else
      ActiveSupport::TimeZone.new("Central Time (US & Canada)")
    end
  end

  def edit_profile_path
    case current_user.role_type
    when "Student" then edit_student_path(current_user.role)
    end
  end
end
