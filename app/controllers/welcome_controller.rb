class WelcomeController < ApplicationController
	before_filter :require_login, except: :index
	before_filter :require_student, except: :index

  def index
		redirect_to current_user ? home_path : login_path
  end

  def dashboard
    active_attends = current_student.attendances.where.not(commitment_status: "No").includes(:event)
		@school = current_student.school
    @user_events = []
    now = DateTime.now
    active_attends.each do |a|
      @user_events.push(a) unless (a.event.start_date_and_time + a.event.duration.hours) - now < 0
    end
    @user_events.sort_by! {|a| a.event.start_date_and_time}
		@trending_events = Event.popular_events(5)
    @nudges_in = current_student.recieved_nudges
    @nudges_out = current_student.sent_nudges
    @zone = current_user.get_time_zone
  end

end
