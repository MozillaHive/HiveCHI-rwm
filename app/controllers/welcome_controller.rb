class WelcomeController < ApplicationController
	before_filter :require_verified_user, except: :index

  #layout false
  def index
  #  sleep(2.0)
    if session[:user_id]
      redirect_to :action => "dashboard", :controller => "welcome"
    else
      redirect_to :action => "login", :controller => "session"
    end
  end

  def dashboard
    active_attends = current_user.attendances.where.not(commitment_status: "No").includes(:event)
		@school = current_user.school
    @user_events = []
    now = DateTime.now
    active_attends.each do |a|
      @user_events.push(a) unless (a.event.start_date_and_time + a.event.duration.hours) - now < 0
    end
    @user_events.sort_by! {|a| a.event.start_date_and_time}
		@trending_events = Event.popular_events(5)

    @nudges_in = current_user.recieved_nudges
    @nudges_out = current_user.sent_nudges
  end

end
